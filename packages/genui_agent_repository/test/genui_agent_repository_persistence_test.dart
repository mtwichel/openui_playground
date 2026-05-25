import 'package:genui_agent_repository/genui_agent_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:openui_core/openui_core.dart';
import 'package:persistence_data_source/persistence_data_source.dart';
import 'package:test/test.dart';

class _MockPersistenceDataSource extends Mock
    implements PersistenceDataSource {}

class _RecordingPersistenceDataSource implements PersistenceDataSource {
  final List<String> writes = [];

  @override
  Future<String?> read() async => null;

  @override
  void write(String contents) => writes.add(contents);

  @override
  Future<void> flush() async {}
}

void main() {
  const defaultTheme = AgentTheme(
    primaryArgb: 0xFF0f172a,
    onPrimaryArgb: 0xFFf8fafc,
    backgroundArgb: 0xFFFFFFFF,
    onBackgroundArgb: 0xFF020817,
    accentArgb: 0xFFf1f5f9,
    onAccentArgb: 0xFF0f172a,
    fontFamily: 'Inter',
  );

  const persistedTheme = GenuiAgentThemeSnapshot(
    primaryArgb: 0xFF112233,
    onPrimaryArgb: 0xFFf8fafc,
    backgroundArgb: 0xFFFFFFFF,
    onBackgroundArgb: 0xFF020817,
    accentArgb: 0xFFf1f5f9,
    onAccentArgb: 0xFF0f172a,
    fontFamily: 'Roboto',
  );

  const persistedSnapshot = GenuiAgentSnapshot(
    name: 'Saved',
    description: 'Desc',
    instructions: 'Inst',
    theme: persistedTheme,
  );

  final library = Library<dynamic>(components: const [], tools: const []);

  group('GenuiAgentRepository.create', () {
    late _MockPersistenceDataSource dataSource;

    setUp(() {
      dataSource = _MockPersistenceDataSource();
    });

    test('hydrates from snapshot', () async {
      when(
        () => dataSource.read(),
      ).thenAnswer((_) async => persistedSnapshot.toJsonString());

      final repository = await GenuiAgentRepository.create(
        dataSource: dataSource,
        library: library,
        defaultTheme: defaultTheme,
      );

      expect(repository.genuiAgent.name, 'Saved');
      expect(repository.genuiAgent.theme.fontFamily, 'Roboto');
    });

    test('uses defaults when read returns null', () async {
      when(() => dataSource.read()).thenAnswer((_) async => null);

      final repository = await GenuiAgentRepository.create(
        dataSource: dataSource,
        library: library,
        defaultTheme: defaultTheme,
      );

      expect(repository.genuiAgent.name, '');
      expect(repository.genuiAgent.theme, defaultTheme);
    });

    test('uses defaults when read returns invalid JSON', () async {
      when(() => dataSource.read()).thenAnswer((_) async => '{');

      final repository = await GenuiAgentRepository.create(
        dataSource: dataSource,
        library: library,
        defaultTheme: defaultTheme,
      );

      expect(repository.genuiAgent.name, '');
      expect(repository.genuiAgent.theme, defaultTheme);
    });
  });

  group('GenuiAgentRepository persistence writes', () {
    late _RecordingPersistenceDataSource dataSource;
    late GenuiAgentRepository repository;

    setUp(() {
      dataSource = _RecordingPersistenceDataSource();
      repository = GenuiAgentRepository(
        GenuiAgent(
          name: '',
          description: '',
          instructions: '',
          theme: defaultTheme,
        ),
        dataSource: dataSource,
      );
    });

    test('setName writes encoded snapshot', () {
      repository.setName('N');

      expect(dataSource.writes, hasLength(1));
      final snapshot = GenuiAgentSnapshot.fromJsonString(
        dataSource.writes.single,
      );
      expect(snapshot?.name, 'N');
    });

    test('setDescription writes encoded snapshot', () {
      repository.setDescription('D');

      final snapshot = GenuiAgentSnapshot.fromJsonString(
        dataSource.writes.single,
      );
      expect(snapshot?.description, 'D');
    });

    test('setInstructions writes encoded snapshot', () {
      repository.setInstructions('I');

      final snapshot = GenuiAgentSnapshot.fromJsonString(
        dataSource.writes.single,
      );
      expect(snapshot?.instructions, 'I');
    });

    test('setTheme writes encoded snapshot', () {
      const updated = AgentTheme(
        primaryArgb: 0xFF112233,
        onPrimaryArgb: 0xFFf8fafc,
        backgroundArgb: 0xFFFFFFFF,
        onBackgroundArgb: 0xFF020817,
        accentArgb: 0xFFf1f5f9,
        onAccentArgb: 0xFF0f172a,
        fontFamily: 'Roboto',
      );

      repository.setTheme(updated);

      final snapshot = GenuiAgentSnapshot.fromJsonString(
        dataSource.writes.single,
      );
      expect(snapshot?.theme.fontFamily, 'Roboto');
    });
  });

  group('GenuiAgentRepository flush', () {
    test('delegates to data source', () async {
      final dataSource = _MockPersistenceDataSource();
      when(() => dataSource.flush()).thenAnswer((_) async {});

      final repository = GenuiAgentRepository(
        GenuiAgent(
          name: '',
          description: '',
          instructions: '',
          theme: defaultTheme,
        ),
        dataSource: dataSource,
      );

      await repository.flush();

      verify(() => dataSource.flush()).called(1);
    });
  });
}

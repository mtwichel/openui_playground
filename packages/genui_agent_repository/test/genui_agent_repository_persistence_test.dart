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

  const persistedTheme = AgentTheme(
    primaryArgb: 0xFF112233,
    onPrimaryArgb: 0xFFf8fafc,
    backgroundArgb: 0xFFFFFFFF,
    onBackgroundArgb: 0xFF020817,
    accentArgb: 0xFFf1f5f9,
    onAccentArgb: 0xFF0f172a,
    fontFamily: 'Roboto',
  );

  final persistedAgent = GenuiAgent(
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

    test('hydrates from persisted JSON', () async {
      when(
        () => dataSource.read(),
      ).thenAnswer((_) async => persistedAgent.toJson());

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

    test('setName writes agent JSON', () {
      repository.setName('N');

      expect(dataSource.writes, hasLength(1));
      final restored = GenuiAgentMapper.fromJson(dataSource.writes.single);
      expect(restored.name, 'N');
    });

    test('setDescription writes agent JSON', () {
      repository.setDescription('D');

      final restored = GenuiAgentMapper.fromJson(dataSource.writes.single);
      expect(restored.description, 'D');
    });

    test('setInstructions writes agent JSON', () {
      repository.setInstructions('I');

      final restored = GenuiAgentMapper.fromJson(dataSource.writes.single);
      expect(restored.instructions, 'I');
    });

    test('setTheme writes agent JSON', () {
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

      final restored = GenuiAgentMapper.fromJson(dataSource.writes.single);
      expect(restored.theme.fontFamily, 'Roboto');
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

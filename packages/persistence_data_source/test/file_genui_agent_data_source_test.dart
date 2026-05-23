import 'dart:io';

import 'package:persistence_data_source/persistence_data_source.dart';
import 'package:test/test.dart';

void main() {
  const theme = GenuiAgentThemeSnapshot(
    primaryArgb: 0xFF112233,
    onPrimaryArgb: 0xFFf8fafc,
    backgroundArgb: 0xFFFFFFFF,
    onBackgroundArgb: 0xFF020817,
    accentArgb: 0xFFf1f5f9,
    onAccentArgb: 0xFF0f172a,
    fontFamily: 'Inter',
  );

  const snapshot = GenuiAgentSnapshot(
    name: 'Saved',
    description: 'D',
    instructions: 'I',
    theme: theme,
  );

  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('genui_persist_test_');
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('FileGenuiAgentDataSource', () {
    test('read returns null when file is missing', () async {
      final dataSource = FileGenuiAgentDataSource(rootDirectory: tempDir);

      expect(await dataSource.read(), isNull);
    });

    test('write and flush persist snapshot', () async {
      final dataSource = FileGenuiAgentDataSource(
        rootDirectory: tempDir,
        debounceDuration: Duration.zero,
      );

      dataSource.write(snapshot);
      await dataSource.flush();

      final restored = await dataSource.read();
      expect(restored?.name, 'Saved');
      expect(restored?.theme.fontFamily, 'Inter');
    });

    test('debounce coalesces rapid writes', () async {
      final dataSource = FileGenuiAgentDataSource(
        rootDirectory: tempDir,
        debounceDuration: const Duration(milliseconds: 50),
      );

      dataSource.write(
        const GenuiAgentSnapshot(
          name: 'First',
          description: '',
          instructions: '',
          theme: theme,
        ),
      );
      dataSource.write(snapshot);
      await Future<void>.delayed(const Duration(milliseconds: 60));

      final restored = await dataSource.read();
      expect(restored?.name, 'Saved');
    });

    test('flush writes pending snapshot before debounce elapses', () async {
      final dataSource = FileGenuiAgentDataSource(
        rootDirectory: tempDir,
        debounceDuration: const Duration(seconds: 10),
      );

      dataSource.write(snapshot);
      await dataSource.flush();

      final restored = await dataSource.read();
      expect(restored?.name, 'Saved');
    });

    test('read returns null for corrupt file', () async {
      final dataSource = FileGenuiAgentDataSource(
        rootDirectory: tempDir,
        debounceDuration: Duration.zero,
      );
      final file = File(
        '${tempDir.path}${Platform.pathSeparator}genui_playground'
        '${Platform.pathSeparator}default.genuiagent',
      );
      await file.parent.create(recursive: true);
      await file.writeAsString('{');

      expect(await dataSource.read(), isNull);
    });
  });
}

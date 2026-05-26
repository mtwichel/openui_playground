import 'dart:io';

import 'package:persistence_data_source/persistence_data_source.dart';
import 'package:test/test.dart';

void main() {
  const payload = '{"name":"Saved"}';

  late Directory tempDir;
  late File file;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('persistence_test_');
    file = File('${tempDir.path}${Platform.pathSeparator}data.txt');
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('FilePersistenceDataSource', () {
    test('read returns null when file is missing', () async {
      final dataSource = FilePersistenceDataSource(file: file);

      expect(await dataSource.read(), isNull);
    });

    test('write and flush persist contents', () async {
      final dataSource = FilePersistenceDataSource(
        file: file,
        debounceDuration: Duration.zero,
      );

      dataSource.write(payload);
      await dataSource.flush();

      expect(await dataSource.read(), payload);
    });

    test('debounce coalesces rapid writes', () async {
      final dataSource = FilePersistenceDataSource(
        file: file,
        debounceDuration: const Duration(milliseconds: 50),
      );

      dataSource.write('{"name":"First"}');
      dataSource.write(payload);
      await Future<void>.delayed(const Duration(milliseconds: 60));

      expect(await dataSource.read(), payload);
    });

    test('flush writes pending contents before debounce elapses', () async {
      final dataSource = FilePersistenceDataSource(
        file: file,
        debounceDuration: const Duration(seconds: 10),
      );

      dataSource.write(payload);
      await dataSource.flush();

      expect(await dataSource.read(), payload);
    });

    test('read returns contents for existing file', () async {
      await file.parent.create(recursive: true);
      await file.writeAsString(payload);

      final dataSource = FilePersistenceDataSource(file: file);

      expect(await dataSource.read(), payload);
    });
  });
}

import 'package:persistence_data_source/src/persistence_data_source.dart';

/// In-memory [PersistenceDataSource] for tests.
class InMemoryPersistenceDataSource implements PersistenceDataSource {
  String? _contents;

  @override
  Future<String?> read() async => _contents;

  @override
  void write(String contents) {
    _contents = contents;
  }

  @override
  Future<void> flush() async {}
}

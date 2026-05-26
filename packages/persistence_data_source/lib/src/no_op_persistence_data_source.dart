import 'package:persistence_data_source/src/persistence_data_source.dart';

/// [PersistenceDataSource] that ignores reads and writes.
class NoOpPersistenceDataSource implements PersistenceDataSource {
  /// Creates a [NoOpPersistenceDataSource].
  const NoOpPersistenceDataSource();

  @override
  Future<String?> read() async => null;

  @override
  void write(String contents) {}

  @override
  Future<void> flush() async {}
}

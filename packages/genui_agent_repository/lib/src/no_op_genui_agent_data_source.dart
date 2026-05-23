import 'package:persistence_data_source/persistence_data_source.dart';

/// Data source that ignores writes (for tests without persistence).
class NoOpGenuiAgentDataSource implements GenuiAgentDataSource {
  @override
  Future<GenuiAgentSnapshot?> read() async => null;

  @override
  void write(GenuiAgentSnapshot snapshot) {}

  @override
  Future<void> flush() async {}
}

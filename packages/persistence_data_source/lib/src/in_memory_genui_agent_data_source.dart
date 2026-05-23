import 'package:persistence_data_source/src/genui_agent_data_source.dart';
import 'package:persistence_data_source/src/genui_agent_snapshot.dart';

/// In-memory [GenuiAgentDataSource] for tests.
class InMemoryGenuiAgentDataSource implements GenuiAgentDataSource {
  GenuiAgentSnapshot? _snapshot;

  @override
  Future<GenuiAgentSnapshot?> read() async => _snapshot;

  @override
  void write(GenuiAgentSnapshot snapshot) {
    _snapshot = snapshot;
  }

  @override
  Future<void> flush() async {}
}

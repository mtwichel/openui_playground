import 'package:persistence_data_source/src/genui_agent_snapshot.dart';

/// Reads and writes [GenuiAgentSnapshot] values for agent persistence.
abstract class GenuiAgentDataSource {
  /// Loads a snapshot from storage, or null if none / invalid.
  Future<GenuiAgentSnapshot?> read();

  /// Schedules a debounced persist of [snapshot].
  void write(GenuiAgentSnapshot snapshot);

  /// Immediately persists any pending snapshot.
  Future<void> flush();
}

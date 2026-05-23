import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:persistence_data_source/src/genui_agent_data_source.dart';
import 'package:persistence_data_source/src/genui_agent_snapshot.dart';

/// Persists agent snapshots to a debounced `.genuiagent` file under [rootDirectory].
class FileGenuiAgentDataSource implements GenuiAgentDataSource {
  /// Creates a [FileGenuiAgentDataSource].
  FileGenuiAgentDataSource({
    Directory? rootDirectory,
    this.debounceDuration = const Duration(milliseconds: 400),
  }) : _rootDirectory = rootDirectory ?? Directory.systemTemp;

  /// Directory that contains the `genui_playground` folder.
  final Directory _rootDirectory;

  /// Delay before flushing a pending [write] to disk.
  final Duration debounceDuration;

  GenuiAgentSnapshot? _pending;
  Timer? _debounceTimer;

  File get _agentFile => File(
    p.join(
      _rootDirectory.path,
      'genui_playground',
      'default.genuiagent',
    ),
  );

  @override
  Future<GenuiAgentSnapshot?> read() async {
    final file = _agentFile;
    if (!file.existsSync()) {
      return null;
    }
    try {
      final contents = await file.readAsString();
      return GenuiAgentSnapshot.fromJsonString(contents);
    } on Object {
      return null;
    }
  }

  @override
  void write(GenuiAgentSnapshot snapshot) {
    _pending = snapshot;
    _debounceTimer?.cancel();
    if (debounceDuration == Duration.zero) {
      unawaited(_writeToDisk(snapshot));
      return;
    }
    _debounceTimer = Timer(debounceDuration, () {
      final pending = _pending;
      if (pending != null) {
        unawaited(_writeToDisk(pending));
      }
    });
  }

  @override
  Future<void> flush() async {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    final pending = _pending;
    if (pending != null) {
      await _writeToDisk(pending);
    }
  }

  Future<void> _writeToDisk(GenuiAgentSnapshot snapshot) async {
    final file = _agentFile;
    await file.parent.create(recursive: true);
    await file.writeAsString(snapshot.toJsonString());
  }
}

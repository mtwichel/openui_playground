import 'dart:async';
import 'dart:io';

import 'package:persistence_data_source/src/persistence_data_source.dart';

/// Persists string contents to a file with debounced writes.
class FilePersistenceDataSource implements PersistenceDataSource {
  /// Creates a [FilePersistenceDataSource].
  FilePersistenceDataSource({
    required File file,
    this.debounceDuration = const Duration(milliseconds: 400),
  }) : _file = file;

  /// Target file on disk.
  final File _file;

  /// Delay before flushing a pending [write] to disk.
  final Duration debounceDuration;

  String? _pending;
  Timer? _debounceTimer;

  @override
  Future<String?> read() async {
    if (!_file.existsSync()) {
      return null;
    }
    try {
      return await _file.readAsString();
    } on Object {
      return null;
    }
  }

  @override
  void write(String contents) {
    _pending = contents;
    _debounceTimer?.cancel();
    if (debounceDuration == Duration.zero) {
      unawaited(_writeToDisk(contents));
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

  Future<void> _writeToDisk(String contents) async {
    await _file.parent.create(recursive: true);
    await _file.writeAsString(contents);
  }
}

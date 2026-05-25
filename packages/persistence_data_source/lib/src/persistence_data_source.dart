/// Reads and writes string contents to storage.
abstract class PersistenceDataSource {
  /// Loads stored contents, or null if none / unreadable.
  Future<String?> read();

  /// Schedules a debounced persist of [contents].
  void write(String contents);

  /// Immediately persists any pending contents.
  Future<void> flush();
}

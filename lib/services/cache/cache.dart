/// Storage abstract class
/// Recommend using https://pub.dev/packages/npreferences as implementation
abstract class Cache {
  /// Save data with primary data types:
  /// String, List<String>, double, int, bool
  Future<bool> saveData<T>(String key, T value);

  /// Get data by key
  Future<T> getData<T>(String key);

  /// Clear all
  Future<bool> clear();
}

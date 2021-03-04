abstract class Store {
  Future<void> init();

  /// Table Preference
  Future<bool> savePref(String key, String value);

  Future<String> getPref(String key);

  Future<bool> removePref(String key);

  /// Clear all database as logout function
  Future<void> clearAll();
}

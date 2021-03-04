import 'package:nft/services/store/store.dart';

class StoreMock implements Store {
  @override
  Future<void> clearAll() async {}

  @override
  Future<String> getPref(String key) async {
    return 'mock';
  }

  @override
  Future<void> init() async {}

  @override
  Future<bool> removePref(String key) async {
    return true;
  }

  @override
  Future<bool> savePref(String key, String value) async {
    return true;
  }
}

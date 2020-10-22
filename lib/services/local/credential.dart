import 'dart:convert';

import 'package:nft/models/local/token.dart';
import 'package:nft/services/local/storage.dart';

class Credential {
  Credential(this._storage);

  // PRIVATE PROPERTIES
  // -----------------
  // Local storage
  final Storage _storage;

  Token _token;

  // PUBLIC PROPERTIES
  // -----------------
  // Get user info
  Token get token => _token;

  // Load credential
  Future<bool> loadCredential() async {
    final String tokenRaw = await _storage.getData<String>(Token.localKey);
    _token = tokenRaw != null
        ? Token.fromJson(jsonDecode(tokenRaw) as Map<String, dynamic>)
        : null;
    return token != null;
  }

  // Store credential
  Future<bool> storeCredential(final Token token, {bool cache = false}) async {
    final bool saveRes = await _storage.saveData(
        Token.localKey, token != null ? jsonEncode(token.toJson()) : null);
    if (saveRes && cache) {
      _token = token;
    }
    return saveRes;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nft/models/local/token.dart';
import 'package:nft/services/local/storage.dart';

class Credential with ChangeNotifier {
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

  set token(Token value) {
    _token = value;
    notifyListeners();
  }

  // Load credential
  Future<bool> loadCredential() async {
    final String tokenRaw = await _storage.getData<String>(Token.localKey);
    token = tokenRaw != null
        ? Token.fromJson(jsonDecode(tokenRaw) as Map<String, dynamic>)
        : null;
    return token != null;
  }

  // Store credential
  Future<bool> storeCredential(final Token newToken,
      {bool cache = false}) async {
    final bool saveRes = await _storage.saveData(Token.localKey,
        newToken != null ? jsonEncode(newToken.toJson()) : null);
    if (saveRes && cache) {
      token = newToken;
    }
    return saveRes;
  }
}

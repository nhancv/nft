import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nft/models/remote/log_in_response.dart';
import 'package:nft/services/remote/auth_api.dart';
import 'package:nft/utils/app_log.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider(this._api);

  //#region PRIVATE PROPERTIES
  // -----------------
  // Authentication api
  final AuthApi _api;

  String _response = '';

  //#endregion

  //#region PUBLIC PROPERTIES
  // -----------------
  String get response => _response;

  set response(String value) {
    _response = value;
    notifyListeners();
  }

  //#endregion

  //#region METHODS
  // -----------------
  /// Call api login
  Future<void> login() async {
    final Response<dynamic> result =
    await _api.logIn().timeout(const Duration(seconds: 30));
    // final Response<dynamic> result =
    //     await api.logInWithError().timeout(Duration(seconds: 30));
    final LoginResponse loginResponse =
    LoginResponse(result.data as Map<String, dynamic>);
    response = loginResponse.toJson().toString();
    logger.d(response);
  }

  //#endregion

}

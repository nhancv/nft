import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nft/models/remote/log_in_response.dart';
import 'package:nft/services/remote/auth_api.dart';

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
    final Response<Map<String, dynamic>> result =
        await _api.logIn().timeout(const Duration(seconds: 30));
    // final Response<dynamic> result =
    //     await api.logInWithError().timeout(Duration(seconds: 30));
    final LoginResponse loginResponse = LoginResponse(result.data);
    response = loginResponse.toJson().toString();
  }

  /// Call api login with error
  Future<LoginResponse> logInWithError() async {
    final Response<Map<String, dynamic>> result =
        await _api.logInWithError().timeout(const Duration(seconds: 30));
    final LoginResponse loginResponse = LoginResponse(result.data);
    response = loginResponse.toJson().toString();
    return loginResponse;
  }

  /// Call api login with exception
  Future<void> logInWithException() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    throw DioError();
  }

//#endregion
}

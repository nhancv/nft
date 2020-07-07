// ignore: implementation_imports
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:nft/models/remote/log_in_response.dart';
import 'package:nft/services/remote/auth_api.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider(this.api);

  final AuthApi api;

  String response = '';

  Future<void> login() async {
    final Response<dynamic> result =
        await api.signIn().timeout(const Duration(seconds: 30));
//    final result = await api.signInWithError().timeout(Duration(seconds: 30));
    final LoginResponse loginResponse =
        LoginResponse(result.data as Map<String, dynamic>);
    response = loginResponse.toJson().toString();
    notifyListeners();
  }
}

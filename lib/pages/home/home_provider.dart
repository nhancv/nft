import 'package:flutter/material.dart';
import 'package:nft/models/remote/log_in_response.dart';
import 'package:nft/provider/remote/auth_api.dart';

class HomeProvider with ChangeNotifier {

  final AuthApi api;

  HomeProvider(this.api);

  String response = "";

  void login() async {
    final result = await api.signIn().timeout(Duration(seconds: 30));
//    final result = await api.signInWithError().timeout(Duration(seconds: 30));
    final loginResponse = LoginResponse(result.data);
    this.response = loginResponse.toJson().toString();
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nft/models/remote/log_in_response.dart';
import 'package:nft/provider/remote/auth_api.dart';

class HomeBloc extends Bloc<bool, String> {
  @override
  String get initialState => "";

  @override
  Stream<String> mapEventToState(bool event) async* {
    AuthApi api = GetIt.I<AuthApi>();
    final result = await api.signIn().timeout(Duration(seconds: 30));
//    final result = await api.signInWithError().timeout(Duration(seconds: 30));
    final loginResponse = LoginResponse(result.data);
    String response = loginResponse.toJson().toString();
    print(response);
    yield response;
  }

}
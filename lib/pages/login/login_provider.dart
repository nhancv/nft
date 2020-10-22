import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nft/models/local/token.dart';
import 'package:nft/models/remote/log_in_response.dart';
import 'package:nft/services/local/credential.dart';
import 'package:nft/services/remote/user_api.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider(this._api, this._credential);

  //#region PRIVATE PROPERTIES
  // -----------------
  // Authentication api
  final UserApi _api;

  // Credential
  final Credential _credential;

  // Store email value
  String _emailValue = '';

  // Flag to check email is valid or not
  bool _emailValid = false;

  // Store password value
  String _passwordValue = '';

  // Flag to visible password field
  bool _obscureText = true;

  // Flag to check form input is valid or not
  bool _formValid = false;

  //#endregion

  //#region PUBLIC PROPERTIES
  // -----------------

  bool get emailValid => _emailValid;

  set emailValid(bool value) {
    _emailValid = value;
    notifyListeners();
  }

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  bool get formValid => _formValid;

  set formValid(bool value) {
    _formValid = value;
    notifyListeners();
  }

  //#endregion

  //#region METHODS
  // -----------------
  // Reset state
  void resetState() {
    _emailValue = '';
    _emailValid = false;
    _passwordValue = '';
    _obscureText = true;
    _formValid = false;
    notifyListeners();
  }

  // Validate from
  void _validateForm() {
    formValid = emailValid && _passwordValue.isNotEmpty;
  }

  /// Call api login
  Future<bool> login() async {
    final Response<Map<String, dynamic>> result =
    await _api.logIn().timeout(const Duration(seconds: 30));
    final LoginResponse loginResponse = LoginResponse(result.data);
    final Token token = loginResponse.data;
    if (token != null) {
      // Save credential
      final bool saveRes =
      await _credential.storeCredential(token, cache: true);
      return saveRes;
    } else {
      throw DioError(
          error: loginResponse.error?.message ?? 'Login error',
          type: DioErrorType.RESPONSE);
    }
  }

  /// Call api login with error
  Future<LoginResponse> logInWithError() async {
    final Response<Map<String, dynamic>> result =
    await _api.logInWithError().timeout(const Duration(seconds: 30));
    final LoginResponse loginResponse = LoginResponse(result.data);
    return loginResponse;
  }

  /// Call api login with exception
  Future<void> logInWithException() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    throw DioError(
        error: 'Login with exception',
        type: DioErrorType.RESPONSE);
  }

  /// On email input change listener to validate form
  void onEmailChangeToValidateForm(final String email) {
    _emailValue = email;
    emailValid = EmailValidator.validate(_emailValue);

    // Update form valid
    _validateForm();
  }

  /// On password input change listener to validate form
  void onPasswordChangeToValidateForm(final String password) {
    _passwordValue = password;

    // Update form valid
    _validateForm();
  }

//#endregion
}

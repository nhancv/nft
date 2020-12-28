import 'package:email_validator/email_validator.dart';
import 'package:nft/services/safety/change_notifier_safety.dart';

class LoginProvider extends ChangeNotifierSafety {
  LoginProvider();

  ///#region PRIVATE PROPERTIES
  /// -----------------
  /// Store email value
  String _emailValue = '';

  /// Flag to check email is valid or not
  bool _emailValid = false;

  /// Store password value
  String _passwordValue = '';

  /// Flag to visible password field
  bool _obscureText = true;

  /// Flag to check form input is valid or not
  bool _formValid = false;

  ///#endregion

  ///#region PUBLIC PROPERTIES
  /// -----------------

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

  ///#endregion

  ///#region METHODS
  /// -----------------
  /// Reset state
  @override
  void resetState() {
    _emailValue = '';
    _emailValid = false;
    _passwordValue = '';
    _obscureText = true;
    _formValid = false;
    notifyListeners();
  }

  /// Validate from
  void _validateForm() {
    formValid = emailValid && _passwordValue.isNotEmpty;
  }

  /// On email input change listener to validate form
  void onEmailChangeToValidateForm(final String email) {
    _emailValue = email;
    emailValid = EmailValidator.validate(_emailValue);

    /// Update form valid
    _validateForm();
  }

  /// On password input change listener to validate form
  void onPasswordChangeToValidateForm(final String password) {
    _passwordValue = password;

    /// Update form valid
    _validateForm();
  }

  ///#endregion
}

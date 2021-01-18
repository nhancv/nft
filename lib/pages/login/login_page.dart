import 'package:flutter/material.dart';
import 'package:nft/models/remote/login_response.dart';
import 'package:nft/pages/login/login_provider.dart';
import 'package:nft/services/app/app_dialog.dart';
import 'package:nft/services/app/app_loading.dart';
import 'package:nft/services/rest_api/api_error.dart';
import 'package:nft/services/rest_api/api_error_type.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_helper.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/widgets/p_appbar_transparency.dart';
import 'package:nft/widgets/w_input_form.dart';
import 'package:nft/widgets/w_keyboard_dismiss.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends PageStateful<LoginPage>
    with WidgetsBindingObserver, ApiError {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  LoginProvider loginProvider;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    loginProvider = Provider.of(context, listen: false);
  }

  @override
  void afterFirstBuild(BuildContext context) {
    loginProvider.resetState();

    /// Init email focus
    /// autofocus in TextField has an issue on next keyboard button
    _emailFocusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Log app life cycle state
    logger.d(state);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PAppBarTransparency(
      child: WKeyboardDismiss(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              /// Logo
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 50),
                child: Image.asset(appTheme.assets.icAppIcon,
                    width: 150, height: 150),
              ),

              /// Login form
              /// Email + password
              Selector<LoginProvider, bool>(
                selector: (_, LoginProvider provider) => provider.emailValid,
                builder: (_, bool emailValid, __) {
                  return WInputForm.email(
                    key: const Key('emailInputKey'),
                    labelText: context.strings.labelEmail,
                    onChanged: loginProvider.onEmailChangeToValidateForm,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    errorText:
                        !emailValid ? context.strings.msgEmailInValid : null,
                    suffixIcon: !emailValid
                        ? const Icon(
                            Icons.error,
                          )
                        : null,
                    onSubmitted: (String term) {
                      AppHelper.nextFocus(
                          context, _emailFocusNode, _passwordFocusNode);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Selector<LoginProvider, bool>(
                selector: (_, LoginProvider provider) => provider.obscureText,
                builder: (_, bool obscureText, __) {
                  return WInputForm.password(
                    key: const Key('passwordInputKey'),
                    labelText: context.strings.labelPassword,
                    suffixIcon: IconButton(
                      icon: obscureText
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        loginProvider.obscureText = !loginProvider.obscureText;
                      },
                    ),
                    obscureText: obscureText,
                    onChanged: loginProvider.onPasswordChangeToValidateForm,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                  );
                },
              ),
              const SizedBox(height: 30),

              /// Example call api with success response
              RaisedButton(
                key: const Key('callApiBtnKey'),
                onPressed: context
                        .select((LoginProvider provider) => provider.formValid)
                    ? () async {
                        final bool success = await apiCallSafety(
                          () => authProvider.login(null, null),
                          onStart: () async {
                            AppLoadingProvider.show(context);
                          },
                          onCompleted: (bool status, bool res) async {
                            AppLoadingProvider.hide(context);
                          },
                          onError: (dynamic error) async {
                            final ApiErrorType errorType =
                                parseApiErrorType(error);
                            AppDialogProvider.show(
                              context,
                              errorType.message,
                              title: 'Error',
                            );
                          },
                          skipOnError: true,
                        );
                        if (success == true) {
                          context
                              .navigator()
                              ?.pushReplacementNamed(AppRoute.routeHome);
                        }
                      }
                    : null,
                child: Text(context.strings.btnLogin),
              ),

              /// Example call api with success http code but with error response,
              /// and how to use function response data instead property approach.
              RaisedButton(
                key: const Key('callApiErrorBtnKey'),
                onPressed: () async {
                  final LoginResponse loginResponse = await apiCallSafety(
                    authProvider.logInWithError,
                    onStart: () async {
                      AppLoadingProvider.show(context);
                    },
                    onCompleted: (bool status, LoginResponse res) async {
                      AppLoadingProvider.hide(context);
                    },
                  );
                  logger.d(loginResponse);
                  if (loginResponse.error != null) {
                    AppDialogProvider.show(
                        context, loginResponse.error.message);
                  }
                },
                child: const Text('call api with error'),
              ),

              /// Example call api with exception return to ui
              /// Note: Exception make app can not hide the app loading with previous ways
              RaisedButton(
                key: const Key('callApiExceptionBtnKey'),
                onPressed: () async {
                  apiCallSafety(
                    authProvider.logInWithException,
                    onStart: () async {
                      AppLoadingProvider.show(context);
                    },
                    onCompleted: (bool status, void res) async {
                      AppLoadingProvider.hide(context);
                    },
                  );
                },
                child: const Text('call api with exception'),
              ),

              const SizedBox(height: 30),

              /// Login button
            ],
          )),
        ),
      ),
    );
  }

  @override
  Future<void> onApiError(dynamic error) async {
    final ApiErrorType errorType = parseApiErrorType(error);
    AppDialogProvider.show(context, errorType.message);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nft/models/remote/login_response.dart';
import 'package:nft/pages/login/login_provider.dart';
import 'package:nft/services/apis/api_error.dart';
import 'package:nft/services/apis/api_error_type.dart';
import 'package:nft/services/app/app_route.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_dialog.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_helper.dart';
import 'package:nft/utils/app_loading.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/widgets/p_appbar_transparency.dart';
import 'package:nft/widgets/w_env.dart';
import 'package:nft/widgets/w_input_form.dart';
import 'package:nft/widgets/w_keyboard_dismiss.dart';

final pLoginProvider = ChangeNotifierProvider((_) => LoginProvider());

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends PageStateful<LoginPage> with WidgetsBindingObserver, ApiError {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late LoginProvider loginProvider;

  @override
  void initDependencies(WidgetRef ref) {
    super.initDependencies(ref);
    loginProvider = ref.read(pLoginProvider);
  }

  @override
  void afterFirstBuild(WidgetRef ref) {
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
    return PAppBarTransparency(
      child: WKeyboardDismiss(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.W),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: WEnv(),
                ),

                /// Logo
                Padding(
                  padding: EdgeInsets.only(top: 100.H, bottom: 50.H),
                  child: Image.asset(appTheme.assets.icAppIcon, width: 150, height: 150),
                ),

                /// Login form
                /// Email + password
                Builder(builder: (BuildContext context) {
                  final bool emailValid = ref.watch(pLoginProvider.select((value) => value.emailValid));
                  return WInputForm.email(
                    key: const Key('emailInputKey'),
                    labelText: context.strings.labelEmail,
                    onChanged: loginProvider.onEmailChangeToValidateForm,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    errorText: !emailValid ? context.strings.msgEmailInValid : null,
                    suffixIcon: !emailValid
                        ? const Icon(
                            Icons.error,
                          )
                        : null,
                    onSubmitted: (String term) {
                      appHelperNextFocus(context, _emailFocusNode, _passwordFocusNode);
                    },
                  );
                }),

                SizedBox(height: 20.H),

                Builder(builder: (BuildContext context) {
                  final bool obscureText = ref.watch(pLoginProvider.select((value) => value.obscureText));
                  return WInputForm.password(
                    key: const Key('passwordInputKey'),
                    labelText: context.strings.labelPassword,
                    suffixIcon: IconButton(
                      icon: obscureText ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                      onPressed: () {
                        loginProvider.obscureText = !loginProvider.obscureText;
                      },
                    ),
                    obscureText: obscureText,
                    onChanged: loginProvider.onPasswordChangeToValidateForm,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                  );
                }),

                SizedBox(height: 30.H),

                /// Example call api with success response
                ElevatedButton(
                  key: const Key('callApiBtnKey'),
                  onPressed: ref.watch(pLoginProvider.select((value) => value.formValid))
                      ? () async {
                          final bool? success = await apiCallSafety(
                            () => authProvider.login(loginProvider.emailValue, loginProvider.passwordValue),
                            onStart: () async {
                              AppLoading.show(ref);
                            },
                            onCompleted: (bool status, bool? res) async {
                              AppLoading.hide(ref);
                            },
                            onError: (dynamic error) async {
                              final ApiErrorType errorType = parseApiErrorType(error);
                              AppDialog.show(
                                ref,
                                errorType.message,
                                title: 'Error',
                              );
                            },
                            skipOnError: true,
                          );
                          if (success == true) {
                            ref.navigator()?.pushReplacementNamed(AppRoute.routeHome);
                          }
                        }
                      : null,
                  child: Text(context.strings.btnLogin),
                ),

                SizedBox(height: 5.H),

                /// Example call api with success http code but with error response,
                /// and how to use function response data instead property approach.
                ElevatedButton(
                  key: const Key('callApiErrorBtnKey'),
                  onPressed: () async {
                    final LoginResponse? loginResponse = await apiCallSafety(
                      authProvider.logInWithError,
                      onStart: () async {
                        AppLoading.show(ref);
                      },
                      onCompleted: (bool status, LoginResponse? res) async {
                        AppLoading.hide(ref);
                      },
                    );
                    logger.d(loginResponse);
                    final String? msg = loginResponse?.error?.message;
                    if (msg != null) {
                      AppDialog.show(ref, msg);
                    }
                  },
                  child: const Text('call api with error'),
                ),

                SizedBox(height: 5.H),

                /// Example call api with exception return to ui
                /// Note: Exception make app can not hide the app loading with previous ways
                ElevatedButton(
                  key: const Key('callApiExceptionBtnKey'),
                  onPressed: () async {
                    apiCallSafety(
                      authProvider.logInWithException,
                      onStart: () async {
                        AppLoading.show(ref);
                      },
                      onCompleted: (bool status, void res) async {
                        AppLoading.hide(ref);
                      },
                    );
                  },
                  child: const Text('call api with exception'),
                ),

                SizedBox(height: 30.H),

                /// Login button
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<int> onApiError(dynamic error) async {
    final ApiErrorType errorType = parseApiErrorType(error);
    await AppDialog.show(ref, errorType.message);
    return 0;
  }
}

import 'package:nft/services/app/app_theme.dart';

enum EnvType {
  dev,
  prod,
}

/// Environment declare here
class Env {
  Env._({
    required this.envType,
    required this.apiBaseUrl,
  });

  /// Dev mode
  factory Env.dev() {
    return Env._(
      envType: EnvType.dev,
      apiBaseUrl: 'https://mock.nhancv.com/api',
    );
  }

  final EnvType envType;
  final String apiBaseUrl;
}

/// Config env
class AppConfig {
  factory AppConfig({required Env env, AppTheme? theme}) {
    I.env = env;
    if (theme != null) {
      I.theme = theme;
    }
    return I;
  }

  AppConfig._private();

  static final AppConfig I = AppConfig._private();

  Env env = Env.dev();
  AppTheme theme = AppTheme.origin();
}

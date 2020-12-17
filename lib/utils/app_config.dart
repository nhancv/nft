import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nft/utils/app_theme.dart';

/// Environment declare here
class Env {
  Env._({@required this.apiBaseUrl});

  /// Dev mode
  factory Env.dev() {
    return Env._(apiBaseUrl: 'https://nhancv.free.beeceptor.com');
  }

  final String apiBaseUrl;
}

/// Config env
class Config {
  factory Config({Env env, AppTheme theme}) {
    if (env != null) {
      I.env = env;
    }
    if (theme != null) {
      I.theme = theme;
    }
    return I;
  }

  Config._private();

  static final Config I = Config._private();

  Env env = Env.dev();
  AppTheme theme = AppTheme.origin();
}

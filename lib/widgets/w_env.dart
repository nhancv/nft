import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateless.dart';
import 'package:nft/utils/app_config.dart';
import 'package:nft/widgets/w_text_rounded.dart';

// ignore: must_be_immutable
class WEnv extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Env env = AppConfig.I.env;
    return env.envType != EnvType.prod
        ? WTextRounded(text: describeEnum(env.envType), color: Colors.red)
        : Container();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateless.dart';
import 'package:nft/utils/app_config.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';

// ignore: must_be_immutable
class WEnv extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Env env = AppConfig.I.env;
    return env.envType != EnvType.prod
        ? Container(
            padding: EdgeInsets.all(2.W),
            margin: EdgeInsets.symmetric(horizontal: 5.W),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(10.W),
            ),
            child: Text(
              describeEnum(env.envType),
              textAlign: TextAlign.center,
              style: boldTextStyle(15.SP, color: Colors.red),
            ),
          )
        : Container();
  }
}

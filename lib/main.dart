import 'package:nft/my_app.dart';
import 'package:nft/utils/app_config.dart';
import 'package:nft/utils/app_theme.dart';

Future<void> main() async {
  /// Init dev config
  AppConfig(env: Env.dev(), theme: AppTheme.origin());
  await myMain();
}

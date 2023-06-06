import 'package:nft/my_app.dart';
import 'package:nft/services/app/app_config.dart';
import 'package:nft/services/app/app_theme.dart';

Future<void> main() async {
  /// Init dev config
  AppConfig(env: Env.dev(), theme: AppTheme.origin());
  await myMain();
}

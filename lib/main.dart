import 'package:nft/my_app.dart';
import 'package:nft/utils/app_config.dart';

void main() async {
  // Init dev config
  Config(environment: Env.dev());
  await myMain();
}

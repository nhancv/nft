import 'package:nft/models/local/token.dart';
import 'package:nft/services/cache/credential.dart';
import 'package:nft/services/rest_api/api_user.dart';
import 'package:nft/services/safety/change_notifier_safety.dart';

class HomeProvider extends ChangeNotifierSafety {
  HomeProvider(this._api, this._credential);

  //#region PRIVATE PROPERTIES
  // -----------------
  // Authentication api
  final ApiUser _api;

  // Credential
  final Credential _credential;

  //#endregion

  //#region PUBLIC PROPERTIES
  // -----------------
  // Get user info
  Token get token => _api.token;

  //#endregion

  //#region METHODS
  // -----------------

  @override
  void resetState() {}

  /// Call logout
  Future<bool> logout() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (token == null) {
      return true;
    }

    // Save credential
    final bool saveRes = await _credential.storeCredential(null, cache: true);
    return saveRes;
  }

//#endregion
}

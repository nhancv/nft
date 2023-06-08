// Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nft/services/apis/api_user.dart';
import 'package:nft/services/app/app_theme.dart';
import 'package:nft/services/cache/cache_preferences.dart';
import 'package:nft/services/cache/credential.dart';
import 'package:nft/services/providers/provider_auth.dart';
import 'package:nft/services/providers/provider_locale.dart';
import 'package:nft/utils/app_dialog.dart';
import 'package:nft/utils/app_loading.dart';

final pAppLoadingProvider = Provider((_) => AppLoading());
final pAppDialogProvider = Provider((_) => AppDialog());
final pAppThemeProvider = ChangeNotifierProvider((_) => AppThemeProvider());
final pCacheProvider = Provider((_) => CachePreferences());
final pCredentialProvider = ChangeNotifierProvider((ref) {
  // https://riverpod.dev/docs/concepts/reading
  // https://docs-v2.riverpod.dev/docs/concepts/combining_providers
  // Use ref to obtain other providers. Don't call READ inside the body of a provider
  return Credential(ref.watch(pCacheProvider));
});
final pApiUserProvider = Provider((ref) {
  final ApiUser api = ApiUser();
  // https://docs-v2.riverpod.dev/docs/concepts/reading#using-reflisten-to-react-to-a-provider-change
  ref.listen<Credential>(pCredentialProvider, (_, next) {
    api.token = next.token;
  });
  return api;
});
final pLocaleProvider = ChangeNotifierProvider((_) => LocaleProvider());
final pAuthProvider = ChangeNotifierProvider((ref) {
  return AuthProvider(ref.watch(pApiUserProvider), ref.watch(pCredentialProvider));
});

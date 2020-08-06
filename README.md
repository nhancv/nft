# nft
Flutter Template

## Update app icon

```
flutter pub get
flutter pub run flutter_launcher_icons:main
```

## Update localization

### Install `flutter_intl` tool
- Jetbrains: https://plugins.jetbrains.com/plugin/13666-flutter-intl
- VS code: https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl

1. Add other locales:

- Update `CFBundleLocalizations` in `ios/Runner/Info.plist` to add new locale
- Run `Tools -> Flutter Intl -> Add Locale`

2. Access to the current locale
```
Intl.getCurrentLocale()
```

3. Change current locale
```
S.load(Locale('vi'));
```

4. Reference the keys in Dart code
```
Widget build(BuildContext context) {
    return Column(children: [
        Text(
            S.of(context).pageHomeConfirm,
        ),
        Text(
            S.current.pageHomeConfirm,// If you don't have `context` to pass
        ),
    ]);
}
```

### Generate intl via cli
```
#https://pub.dev/packages/intl_utils
flutter pub run intl_utils:generate
```

## Clone initial setup

- Search and Replace All `nft` to new package id
- Search and Replace All `NFT App` to new App display name
- Search and Replace All `com.app.nft` to new App bundle id
- Update directory folder path name of Android (`android/app/src/main/kotlin/`) same with new App bundle id

## Structure
```
lib
  |-generated                     ---> auto genrated by flutter_intl
  |-I10n                          ---> auto genrated by flutter_intl
    |-intl_en.arb                 ---> define your translation here
  |-models                        ---> places of object models
  |-pages                         ---> define all pages/screens of application
    |-home                        ---> we should organize as app module (eg: home, about, ...) rather then platform module (eg: activity, dialog, ...)
      |-home_provider.dart
      |-home_screen.dart
  |-services                      ---> define app services (database service, network service)
    |-remote
      |-api.dart
      |-auth_api.dart
    |-app_loading.dart
    |-local_storage.dart
    |-logging.dart
  |-utils                         ---> app utils
    |-app_asset.dart
    |-app_config.dart
    |-app_constant.dart
    |-app_extension.dart
    |-app_helper.dart
    |-app_log.dart
    |-app_route.dart
    |-app_style.dart
    |-app_theme.dart
  |-widgets                       ---> app widgets
  |-main.dart                     ---> each main.dart file point to each env of app. Ex: default main.dart for dev env, create new main_prod.dart for prod env
  |-my_app.dart                   ---> application bootstrap
test                              ---> widget/unit testing
test_driver                       ---> integration testing
```

## Versioning
```
version: 1.0.6+2003271407
---
Version name: 1.0.6
Version code: 2003271407
```

Version name: major.minor.build/patch
Version code: yymmddHHMM

* Remember to increase bold the version name and code also.

https://medium.com/p/2dd558f8b524

## Multi env
- Create new env factory in app_config.dart.
- Create new file called main_<env>.dart. Ex: main_prod.dart and config to prod env
- Build with flutter
```
flutter build ios -t lib/main_prod.dart
```

## Testing
- Unit test: https://flutter.dev/docs/cookbook/testing/unit/introduction
```
flutter test test/widget_test.dart
```
- Integration test: https://flutter.dev/docs/cookbook/testing/integration/introduction
```
flutter drive --target=test_driver/app.dart
```
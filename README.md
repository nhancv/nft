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
        new Text(
            S.of(context).pageHomeConfirm,
        ),
        new Text(
            S.current.pageHomeConfirm,// If you don't have `context` to pass
        ),
    ]);
}
```

## Clone initial setup

- Search and Replace All `nft` to new package id
- Search and Replace All `NFT App` to new App display name
- Search and Replace All `com.app.nft` to new App bundle id
- Update directory folder path name of Android (`android/app/src/main/kotlin/`) same with new App bundle id

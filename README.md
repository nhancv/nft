# nft
Flutter Template

```
Flutter 2.0.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 60bd88df91 (22 hours ago) • 2021-03-03 09:13:17 -0800
Engine • revision 40441def69
Tools • Dart 2.12.0
```

## Initial setup

### Change App display name

- Search and Replace All `NFT App` to new App display name

### Change App bundle id

- Search and Replace All `com.nhancv.nft` to new App bundle id
- Update directory folder path name of Android (`android/app/src/main/kotlin/`) same with new App bundle id

### Change Flutter app package

- Search and Replace All `nft` to new package name


## Update app icon

- Update app icon resources: 
+ `assets/base/icons/adaptive_icon_background.png`
+ `assets/base/icons/adaptive_icon_foreground.png`
+ `assets/base/icons/app_icon_ad.png`
+ `assets/base/icons/app_icon_ios.png`

- Run command to generate native resources
```
flutter pub get
flutter pub run flutter_launcher_icons:main
```

## Update splash screen

### Android

- Add `launch_bg.png` and `launch_image.png` to
```
+ android/app/src/main/res/drawable-mdpi
+ android/app/src/main/res/drawable-xhdpi
+ android/app/src/main/res/drawable-xxhdpi
```

- Update `android/app/src/main/res/drawable/launch_background.xml`
```
<?xml version="1.0" encoding="utf-8"?>
<!-- Modify this file to customize your launch splash screen -->
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@android:color/white" />

    <!-- You can insert your own image assets here -->
    <item>
        <bitmap
            android:gravity="fill_horizontal|fill_vertical"
            android:src="@drawable/launch_bg" />
    </item>
    <item>
        <bitmap
            android:gravity="center"
            android:src="@drawable/launch_image" />
    </item>
</layer-list>
```

### iOS

- Add `LaunchBackground.imageset` and `LaunchImage.imageset` to `ios/Runner/Assets.xcassets`
- Open `ios/Runner.xcworkspace`
- Select `Runner/Runner/LaunchScreen.storyboard`
```
+ Expand View Controller Scene -> View Controller -> View
+ Add object -> Search ImageView -> Drag ImageView object to View (front of LaunchImage) 
-> Select Attributes inspector -> Custom Image to LaunchBackground 
-> Change View Content Mode to Scale To Fill -> Add 0, 0, 0, 0 as constrains 
-> Save	
```

## Localizations

https://flutter.dev/docs/development/accessibility-and-localization/internationalization

### Install `flutter_intl` tool
- JetBrains: https://plugins.jetbrains.com/plugin/13666-flutter-intl
- VS code: https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl

1. Add other locales:
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
flutter pub get
flutter pub run intl_utils:generate
```

## Structure
```
lib/
  |-generated/                     ---> auto genrated by flutter_intl
  |-l10n/                          ---> place internalization files
    |-intl_*.arb                   ---> define your translation text here
  |-models/                        ---> place object models
    |-local/                       ---> place local models
    |-remote/                      ---> place remote models
  |-pages/                         ---> define all pages/screens of application
    |-home/                        ---> place app home module included home ui and logic. We should organize as app module (eg: home, about, ...) rather then platform module (eg: activity, dialog, ...)
      |-home_page.dart             ---> define home ui
      |-home_provider.dart         ---> define home logic
  |-services/                      ---> place app services (database service, network service)
    |-app/                         ---> place local data services
      |-app_dialog.dart            ---> define app dialog service. Easy to show or hide alert dialog
      |-app_loading.dart           ---> define app loading service. Easy to show or hide loading view
      |-dynamic_size.dart          ---> define dynamic size service. Adapting screen and font size
      |-locale_provider.dart       ---> define locale provider service. Provide update locale
      |-state_safety.dart          ---> define sate safety service. It's used for Stateful widget, check mounted before setState
    |-cache/                       ---> place local data services
      |-credential.dart            ---> define app credential
      |-storage.dart               ---> define storage service
      |-storage_preferences.dart   ---> define storage with shared preferences service
    |-rest_api/                    ---> place remote services
      |-api.dart                   ---> define api base class
      |-api_error.dart             ---> define api error/exception handler
      |-api_user.dart              ---> define sample of api user
      |-error_type.dart            ---> define api error type
    |-safety/                      ---> place safety abstract class for widget, change notifier
      |-base_stateful.dart         ---> define base stateful widget, provide app theme, dynamic size
      |-base_stateless.dart        ---> define base stateless widget, provide app theme, dynamic size
      |-change_notifier_safety.dart---> define safety change notifier
      |-page_stateful.dart         ---> define stateful abstract for page 
      |-state_safety.dart          ---> define setState safety
    |-store/                       ---> place local store service
      |-store.dart                 ---> define abstract store
      |-store_mock.dart            ---> define mock store
  |-utils/                         ---> place app utils
    |-app_asset.dart               ---> define app assets
    |-app_config.dart              ---> define app config multi environment
    |-app_extension.dart           ---> define app extension
    |-app_helper.dart              ---> define app helper. Provide util function such as show popup, toast, flushbar, orientation mode
    |-app_log.dart                 ---> define app logger. Log safety with production mode
    |-app_route.dart               ---> define app route logic
    |-app_style.dart               ---> define app style
    |-app_theme.dart               ---> define app theme. Provide multi theme such as dart, light
  |-widgets/                       ---> place app widgets
    |-p_appbar_empty.dart          ---> define wrapper widget use for page, color status bar but empty appbar 
    |-p_appbar_transparency.dart   ---> define wrapper widget use for page, transparent status bar
    |-p_material.dart              ---> define wrapper widget use for page, provide material app block
    |-w_dismiss_keyboard.dart      ---> define component widget with auto dismiss keyboard when click on screen
  |-main.dart                      ---> each main.dart file point to each env of app. Ex: default main.dart for dev env, create new main_prod.dart for prod env
  |-my_app.dart                    ---> application bootstrap
test/                              ---> place app unit, widget tests
  |-counter_provider_test.dart     ---> define test provider script
  |-counter_widget_test.dart       ---> define test widget script
  |-navigator_test.dart            ---> define test navigator script
  |-rest_api_test.dart             ---> define test rest api script
test_driver/                       ---> place integration testing
  |-app.dart                       ---> define application bootstrap for integration testing
  |-app_test.dart                  ---> define integration test script
```

## Versioning
```
version: 1.0.1+202101001
---
Version name: 1.0.1
Version code: 202101001
```

Version name: major.minor.build
Version code: yyyymm<build number from 000>

* Remember to increase bold the version name and code as well.

https://medium.com/p/2dd558f8b524

## Multi env
- Create a new env factory in app_config.dart.
- Create a new file called main_<env>.dart. Ex: main_prod.dart and config to prod env
- Build with specific env
```
# default as dev
flutter build ios

# prod
flutter build ios -t lib/main_prod.dart
```

## Testing
- Unit test: https://flutter.dev/docs/cookbook/testing/unit/introduction
```
flutter test

# Test and export coverage information
# output to coverage/lcov.info
flutter test --coverage

# Convert to html
## Install lcov tool to convert lcov.info file to HTML pages
- Installing in Ubuntu:
sudo apt-get update -qq -y
sudo apt-get install lcov -y
- Installing in Mac:
brew install lcov

- Gen html files
genhtml coverage/lcov.info -o coverage/html

# Open in the default browser (mac):
open coverage/html/index.html

```
- Integration test: https://flutter.dev/docs/cookbook/testing/integration/introduction
```
flutter drive --target=test_driver/app.dart
```

## Release and publish to store

### Android 

- Docs: https://flutter.dev/docs/deployment/android
- Prepare release keystore:
- Create `android/key.properties`
    
```
keyAlias=
keyPassword=
storePassword=
storeFile=keystores/keystore-release.jks

#KEY INFO
#CN(first and last name): 
#OU(organizational unit): 
#O(organization): 
#L(City or Locality): 
#ST(State or Province): 
#C(country code): 
```
 
- Create `android/app/keystores/keystore-release.jks`
```
cd android/app/keystores/
export keyAlias=
export keyPassword=
export storePassword=
keytool -genkey -v -keystore keystore-release.jks -alias $keyAlias -keyalg RSA -keysize 2048 -validity 1000000 -storepass $storePassword -keypass $keyPassword
```

- Build release binary. There 2 type of binary app bundle with optimized size when download from Store and apk type.

+ To build apk
```
flutter build apk
```
+ To build app bundle
```
flutter build appbundle
```

* Get binary from the path which displayed in console after build successfully.

### iOS

- Docs: https://flutter.dev/docs/deployment/ios
- Create certs to build on `https://developer.apple.com`
    + Create app identity
    + Create certification for app
    + Create provision profile point to app identity and certification
- Create application on `https://appstoreconnect.apple.com`
- Build dart files first, at project root level
```
flutter build ios
```
- Build native application on Xcode -> Select build target to `Any iOS devices` -> Select `Product` -> `Archive` -> Upload to Store

------------------------------

## Integrate firebase

- Checkout `firebase` branch
- https://medium.com/@nhancv/flutter-create-a-firebase-project-183b681e4cb5

## Integrate firebase analytics

- Checkout `firebase_analytics` branch
- https://medium.com/@nhancv/flutter-analytics-integration-768ae76a8077


## Integrate firebase crashlytics

- Checkout `firebase_crashlytics` branch
- https://medium.com/@nhancv/flutter-crashlytics-integration-17530e24ba5c

## Integrate OneSignal Push Notification

- https://medium.com/@nhancv/flutter-integrate-onesignale-push-notification-286cd6542e0a

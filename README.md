# nft

nhancv's Flutter Template

[Wiki] (https://github.com/nhancv/nft/wiki)

```
nft|master⚡ ⇒ flutter --version         
Flutter 3.10.3 • channel stable • https://github.com/flutter/flutter.git
Framework • revision f92f44110e (5 days ago) • 2023-06-01 18:17:33 -0500
Engine • revision 2a3401c9bb
Tools • Dart 3.0.3 • DevTools 2.23.1
```

## Initial setup

### Change Flutter app package

- Search and Replace All `nft` to new package name

### Change App display name

- Search and Replace All `NFT App` to new App display name

### Change App bundle id

- Search and Replace All `com.nhancv.nft` to new App bundle id
- Update directory folder path name of Android (`android/app/src/main/kotlin/`) same with new App bundle id

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
  |-services/                      ---> place app services
    |-apis/                        ---> place rest APIs (networks, API base, error/exception handler, example, error type) 
    |-app/                         ---> place app configs (assets, env, route, theme)
    |-cache/                       ---> place local data services (storage, credential, preferences)
    |-safety/                      ---> place safety abstract class for widget, change notifier
    |-store/                       ---> place local store service
      |-store.dart                 ---> define abstract store
      |-store_mock.dart            ---> define mock store
  |-utils/                         ---> place app utils, extensions, helpers, loggers, styles
  |-widgets/                       ---> place app widgets
  |-main.dart                      ---> each main.dart file point to each env of app. Ex: default main.dart for dev env, create new main_prod.dart for prod env
  |-my_app.dart                    ---> application bootstrap
test/                              ---> place app unit, widget tests
test_driver/                       ---> place integration tests
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

## Optimize First Run performance

https://flutter.dev/docs/perf/rendering/shader

- On Android, “first run” means that the user might see jank the first time opening the app after a fresh installation. Subsequent runs should be fine.
- On iOS, “first run” means that the user might see jank when an animation first occurs every time the user opens the app from scratch.

How to use SkSL warmup?

```
1. Run the app with --cache-sksl turned on to capture shaders in SkSL
flutter run --profile --cache-sksl --purge-persistent-cache

2. Play with the app to trigger as many animations as needed; particularly those with compilation jank.

3. Press M at the command line of flutter run to write the captured SkSL shaders into a file named something like flutter_01.sksl.json. For best results, capture SkSL shaders on actual Android and iOS devices separately.

4. Build the app with SkSL warm-up using the following, as appropriate:
Android:
flutter build apk --bundle-sksl-path flutter_01.sksl.json
or
flutter build appbundle --bundle-sksl-path flutter_01.sksl.json

iOS:
flutter build ios --bundle-sksl-path flutter_01.sksl.json
```

## Integrate facebook/google/firebase key hash

### Gen new key store
```
keytool -genkey -v -keystore keystore-release.jks -alias KEY_ALIAS -keyalg RSA -keysize 2048 -validity 1000000 -storepass KEY_STORE_PASS -keypass KEY_PASS
```

### Get facebook key hashes
```
keytool -exportcert -alias androiddebugkey -keystore keystore-debug.jks | openssl sha1 -binary | openssl base64

=> enter storePassword

Ex: smKEjJWY1ZgwHQvuE3qGjwMC6jk=
```

### Get google/firebase key hash
```
keytool -exportcert -alias androiddebugkey -keystore keystore-debug.jks -list -v

=> enter storePassword

Alias name: androiddebugkey
Creation date: May 5, 2016
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Thu May 05 15:32:50 ICT 2016 until: Sat Apr 28 15:32:50 ICT 2046
Certificate fingerprints:
     MD5:  8E:B3:66:00:35:D9:88:80:D5:DC:84:F9:2A:AE:0B:98
     SHA1: B2:62:84:8C:95:98:ED:98:30:1D:0B:EE:2F:CA:86:8F:03:02:E9:D9
     SHA256: 45:ED:59:3D:6F:41:F8:5F:04:45:FC:7D:AD:77:1A:9B:B4:33:43:27:F4:30:92:10:8E:07:D9:E9:AA:6F:8B:9C
     Signature algorithm name: SHA1withRSA
     Version: 1
```

### Deal with signed apk on google play store. 
```
It enables if Google Play App Signing, key hash from local release keystore file just use for upload to store, new key hash will be generated after upload and it’s a final key hash for distribution. 

Go to Play store -> Release management -> App signing -> Get SHA-1 certificate fingerprint from App signing certificate block as show in this image.

(Select App -> Release -> Setup -> App integrity for new play console)
```
#### Convert SHA-1 to facebook key hash
```
echo <SHA-1 HEX> | xxd -r -p | openssl base64

ex: 
echo B2:62:84:8C:95:98:ED:98:30:1D:0B:EE:2F:CA:86:8F:03:02:E9:D9 | xxd -r -p | openssl base64
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
flutter pub get
find . -name "Podfile" -execdir pod install \;
flutter build ios
```
- Build native application on Xcode -> Select build target to `Any iOS devices` -> Select `Product` -> `Archive` -> Upload to Store
- [Optional] Build iap file in release mode. It combines steps `build ios` and `archive`, and it requires the export plist config. This one is use for CI build, for manual, I recommend using XCode 
```
flutter build ipa --release --export-options-plist=$HOME/export_options.plist -t lib/main.dart
```

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

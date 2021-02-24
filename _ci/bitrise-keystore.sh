#!/usr/bin/env bash

KEY_PATH='android/key.properties'

# generate key.properties file
cat <<EOT >> $KEY_PATH
keyAlias=$BITRISEIO_ANDROID_KEYSTORE_ALIAS
keyPassword=$BITRISEIO_ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD
storePassword=$BITRISEIO_ANDROID_KEYSTORE_PASSWORD
storeFile=$HOME/android/keystore-release.jks
EOT

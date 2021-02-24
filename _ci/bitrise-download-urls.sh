#!/usr/bin/env bash

#BITRISE_PERMANENT_DOWNLOAD_URL_MAP='app-universal-release.apk=>https://app.bitrise.io/artifact/98e1ae554fde01b4/download|app-release.aab=>https://app.bitrise.io/artifact/5f2b684b4cccdfac/download|flutter_json_test_results.json=>https://app.bitrise.io/artifact/5e8ada02e18e8700/download'

BITRISE_APK_URL=""
BITRISE_AAB_URL=""
APK_FILE=app-universal-release.apk
AAB_FILE=app-release.aab
IFS='|' read -ra URL <<< "$BITRISE_PERMANENT_DOWNLOAD_URL_MAP"
for i in "${URL[@]}"; do
  if [[ $i == $APK_FILE* ]];
	then
		BITRISE_APK_URL=$(echo $i | sed "s/${APK_FILE}=>//")
	elif [[ $i == $AAB_FILE* ]];
	then
		BITRISE_AAB_URL=$(echo $i | sed "s/${AAB_FILE}=>//")
	fi

done

echo "BITRISE_APK_URL: $BITRISE_APK_URL"
echo "BITRISE_AAB_URL: $BITRISE_AAB_URL"
envman add --key BITRISE_APK_URL --value "$BITRISE_APK_URL"
envman add --key BITRISE_AAB_URL --value "$BITRISE_AAB_URL"

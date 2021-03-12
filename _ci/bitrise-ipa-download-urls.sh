#!/usr/bin/env bash

#BITRISE_PERMANENT_DOWNLOAD_URL_MAP='export_options.plist=>https://app.bitrise.io/artifact/nhancv_depchai_xxxxx/download|flutter_json_test_results.json=>https://app.bitrise.io/artifact/nhancv_depchai_xxxxx/download|Runner.app.zip=>https://app.bitrise.io/artifact/nhancv_depchai_xxxxx/download|Runner.dSYM.zip=>https://app.bitrise.io/artifact/nhancv_depchai_xxxxx/download|Runner.ipa=>https://app.bitrise.io/artifact/nhancv_depchai_xxxxx/download|Runner.xcarchive.zip=>https://app.bitrise.io/artifact/nhancv_depchai_xxxxx/download'

BITRISE_IPA_URL=""
IPA_FILE='Runner.ipa'
IFS='|' read -ra URL <<< "$BITRISE_PERMANENT_DOWNLOAD_URL_MAP"
for i in "${URL[@]}"; do
  if [[ $i == $IPA_FILE* ]];
	then
		BITRISE_IPA_URL=$(echo $i | sed "s/${IPA_FILE}=>//")
	fi

done

echo "BITRISE_IPA_URL: $BITRISE_IPA_URL"
envman add --key BITRISE_IPA_URL --value "$BITRISE_IPA_URL"

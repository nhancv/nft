#!/usr/bin/env bash

# Parse app build version
APP_BUILD_VERSION=$(cat pubspec.yaml | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[: ']//g'')
echo "APP_BUILD_VERSION: $APP_BUILD_VERSION"
envman add --key APP_BUILD_VERSION --value "$APP_BUILD_VERSION"


# Parse change log
c=0
APP_CHANGELOG=""
while read p; do
	if [[ $p == \#\#* ]]; 
	then
		let c++
	fi
	if [[ $c == 2 ]]; 
	then
		break
	fi
	APP_CHANGELOG=$APP_CHANGELOG$p$'\n'
done < CHANGELOG.md
echo "APP_CHANGELOG: $APP_CHANGELOG"
envman add --key APP_CHANGELOG --value "$APP_CHANGELOG"
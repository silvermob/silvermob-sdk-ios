#!/bin/sh

openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in ./scripts/certs/distribution.p12.enc -d -a -out ./scripts/certs/distribution.p12
openssl aes-256-cbc -k "$SECURITY_PASSWORD" -in ./scripts/certs/SilverMobSdkDemo.mobileprovision.enc -d -a -out ./scripts/certs/SilverMobSdkDemo.mobileprovision


security create-keychain -p travis ios-build.keychain
security import ./scripts/certs/apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/certs/distribution.p12 -k ~/Library/Keychains/ios-build.keychain -P "" -T /usr/bin/codesign
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./scripts/certs/SilverMobSdkDemo.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/

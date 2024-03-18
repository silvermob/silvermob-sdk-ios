[![Build Status](https://api.travis-ci.org/prebid/prebid-mobile-ios.svg?branch=master)](https://travis-ci.org/prebid/prebid-mobile-ios)

# Prebid Mobile iOS SDK

To work with Prebid Mobile, you will need accesss to a Prebid Server. See [this page](https://docs.prebid.org/prebid-server/overview/prebid-server-overview.html) for options.

## Use Cocoapods?

Easily include the Prebid Mobile SDK for your primary ad server in your Podfile/

```
platform :ios, '11.0'

target 'MyAmazingApp' do 
    pod 'SilverMobSdk'
end
```

## Build framework from source

Build Prebid Mobile from source code. After cloning the repo, from the root directory run

```
./scripts/buildSilverMobSdk.sh
```

to output the Prebid Mobile framework.


## Test Prebid Mobile

Run the test script to run unit tests and integration tests.

```
./scripts/testSilverMobSdk.sh
```


## Carthage

`2.1.6` version is available to build SilverMobSdk with Carthage. For that, please, put the following content to your `Cartfile`:

```
github "prebid/prebid-mobile-ios" == 2.2.0-carthage
```
Run this command in order to build SilverMobSdk with Carthage:

```
carthage update --use-xcframeworks --platform ios
```
Note that `SilverMobSdkGAMEventHandlers`, `SilverMobSdkAdMobAdapters`, `SilverMobSdkMAXAdapters` are not available to build with Carthage.

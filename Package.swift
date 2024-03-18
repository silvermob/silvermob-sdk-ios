// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(

    name: "SilverMobSdk",

    platforms: [
        .iOS(.v10)
    ],
    
    products: [
        
        .library(
            name: "SilverMobSdk",
            targets: ["SilverMobSdk"])
    ],

    targets: [
        .target(
            name: "SilverMobSdk",
            path: "SilverMobSdk"
        )
    ],
    
    swiftLanguageVersions: [.v5]

)

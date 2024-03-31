Pod::Spec.new do |s|

  s.name         = "SilverMobSdk"
  s.version      = "2.2.0"
  s.summary      = "SilverMobSdk is an ads serving SDK for SilverMob ads."

  s.description  = <<-DESC
    SilverMobSdk is an ads serving SDK for SilverMob ads."
    DESC
  s.homepage     = "https://silvermob.com"


  s.license      = { :type => "Apache License, Version 2.0", :text => <<-LICENSE
    Copyright 2018-2021 Prebid.org, Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
    }

  s.author                 = { "ArtChaos s.r.o." => "contact@silvermob.com" }
  s.platform     	   = :ios, "11.0"
  s.swift_version 	   = '5.0'
  s.source      	   = { :git => "https://github.com/silvermob/silvermob-sdk-ios.git", :tag => "#{s.version}" }
  s.xcconfig 		   = { :LIBRARY_SEARCH_PATHS => '$(inherited)',
			       :OTHER_CFLAGS => '$(inherited)',
			       :OTHER_LDFLAGS => '$(inherited)',
			       :HEADER_SEARCH_PATHS => '$(inherited)',
			       :FRAMEWORK_SEARCH_PATHS => '$(inherited)'
			     }
  s.requires_arc = true

  s.frameworks = [ 'UIKit', 
                   'Foundation', 
                   'MapKit', 
                   'SafariServices', 
                   'SystemConfiguration',
                   'AVFoundation',
                   'CoreGraphics',
                   'CoreLocation',
                   'CoreTelephony',
                   'CoreMedia',
                   'QuartzCore'
                 ]
  s.weak_frameworks  = [ 'AdSupport', 'StoreKit', 'WebKit' ]

  # Support previous intagration
  s.default_subspec = 'core'

  s.subspec 'core' do |core|
    core.source_files = 'SilverMobSdk/**/*.{h,m,swift}'
    
    core.private_header_files = [ 
      'SilverMobSdk/SilverMobSdkRendering/Networking/Parameters/PBMParameterBuilderService.h', 
      'SilverMobSdk/SilverMobSdkRendering/Prebid+TestExtension.h',
      'SilverMobSdk/SilverMobSdkRendering/3dPartyWrappers/OpenMeasurement/PBMOpenMeasurementFriendlyObstructionTypeBridge.h',
      'SilverMobSdk/ConfigurationAndTargeting/InternalUserConsentDataManager.h',
      'SilverMobSdk/SilverMobSdkRendering/Networking/Parameters/PBMUserConsentParameterBuilder.h'
    ]
    core.vendored_frameworks = 'Frameworks/OMSDK-Static_Prebidorg.xcframework'
  end
end
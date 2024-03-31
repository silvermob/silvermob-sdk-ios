Pod::Spec.new do |s|

  s.name         = "SilverMobSdkMAXAdapters"
  s.version      = "2.2.0"
  s.summary      = "The bridge between SilverMobSdk SDK and Applovin MAX SDK."

  s.description  = "The bridge between SilverMobSdk SDK and GMA SDK."
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

  s.author		= { "ArtChaos s.r.o." => "contact@silvermob.com" }
  s.platform     	= :ios, "11.0"
  s.swift_version 	= '5.0'
  s.source       	= { :git => "https://github.com/silvermob/silvermob-sdk-ios.git", :tag => "#{s.version}" }
  s.xcconfig 		= { :LIBRARY_SEARCH_PATHS => '$(inherited)',
			    :OTHER_CFLAGS => '$(inherited)',
			    :OTHER_LDFLAGS => '$(inherited)',
			    :HEADER_SEARCH_PATHS => '$(inherited)',
			    :FRAMEWORK_SEARCH_PATHS => '$(inherited)'
			  }

  s.source_files = 'EventHandlers/SilverMobSdkMAXAdapters/**/*.{h,m,swift}'
  s.static_framework = true

  s.dependency 'SilverMobSdk', '2.2.0'
  s.dependency 'AppLovinSDK'

end

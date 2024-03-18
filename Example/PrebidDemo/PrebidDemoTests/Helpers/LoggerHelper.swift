/*   Copyright 2018-2021 Prebid.org, Inc.
 
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
 
  http://www.apache.org/licenses/LICENSE-2.0
 
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  */

import Foundation
import SilverMobSdk

class LoggerHelper {
    
    private let queue = DispatchQueue(label: "UtilitiesForTesting_LoggerHelper")
    private var locksCount = 0
    
    init() {
        queue.sync {
            if locksCount == 0 {
                LoggerHelper.prepareLogFile()
            }
            locksCount += 1
        }
    }
    
    deinit {
        queue.sync {
            locksCount -= 1
            if locksCount == 0 {
                LoggerHelper.releaseLogFile()
            }
        }
    }
    
    @objc class func prepareLogFile() {
        Log.clearLogFile()
        Log.logToFile = true
    }
    
    @objc class func releaseLogFile() {
        Log.logToFile = false
        Log.clearLogFile()
        
    }
}

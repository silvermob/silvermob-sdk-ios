//
//  MockPBMAbstractCreative.swift
//  SilverMobSdkTests
//
//  Created by Olena Stepaniuk on 06.03.2023.
//  Copyright © 2023 AppNexus. All rights reserved.
//

import Foundation
@testable import SilverMobSdk

class MockPBMAbstractCreative: PBMAbstractCreative {
 
    var modalManagerDidFinishPopCallback: PBMVoidBlock?
    var modalManagerDidLeaveAppCallback: PBMVoidBlock?
    
    override func modalManagerDidFinishPop(_ state: PBMModalState) {
        modalManagerDidFinishPopCallback?()
    }
    
    override func modalManagerDidLeaveApp(_ state: PBMModalState) {
        modalManagerDidLeaveAppCallback?()
    }
}

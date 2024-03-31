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

import XCTest
@testable import SilverMobSdk

class PrebidTest: XCTestCase {
    
    private var logToFile: LogToFileLock?
    
    private var sdkConfiguration: SilverMob!
    private let targeting = Targeting.shared
    
    override func setUp() {
        super.setUp()
        sdkConfiguration = SilverMob.mock
    }
    
    override func tearDown() {
        logToFile = nil
        sdkConfiguration = nil
        
        SilverMob.reset()
        
        super.tearDown()
    }
    
    func testInitialValues() {
        let sdkConfiguration = SilverMob.shared
        
        checkInitialValue(sdkConfiguration: sdkConfiguration)
    }
    
    func testInitializeSDK_OptionalCallback() {
        // init callback should be optional
        SilverMob.initializeSDK()
    }
    
    func testInitializeSDK() {
        try? SilverMob.shared.setCustomPrebidServer(url: "https://prebid-server-test-j.prebid.org/openrtb2/auction")
        
        let expectation = expectation(description: "Expected successful initialization")
        
        SilverMob.initializeSDK { status, error in
            if case .succeeded = status {
                expectation.fulfill()
            }
            
            if let error = error {
                XCTFail("Failed with error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testLogLevel() {
        let sdkConfiguration = SilverMob.shared
        
        XCTAssertEqual(sdkConfiguration.logLevel, Log.logLevel)
        
        sdkConfiguration.logLevel = .verbose
        XCTAssertEqual(Log.logLevel, .verbose)
        
        Log.logLevel = .warn
        XCTAssertEqual(sdkConfiguration.logLevel, .warn)
    }
    
    func testDebugLogFileEnabled() {
        
        let sdkConfiguration = SilverMob.shared
        let initialValue = sdkConfiguration.debugLogFileEnabled
        
        XCTAssertEqual(initialValue, Log.logToFile)
        
        sdkConfiguration.debugLogFileEnabled = !initialValue
        XCTAssertEqual(Log.logToFile, !initialValue)
        
        Log.logToFile = initialValue
        XCTAssertEqual(sdkConfiguration.debugLogFileEnabled, initialValue)
    }
    
    func testLocationValues() {
        let sdkConfiguration = SilverMob.shared
        XCTAssertTrue(sdkConfiguration.locationUpdatesEnabled)
        sdkConfiguration.locationUpdatesEnabled = false
        XCTAssertFalse(sdkConfiguration.locationUpdatesEnabled)
    }
    
    func testShared() {
        let firstConfig = SilverMob.shared
        let newConfig = SilverMob.shared
        XCTAssertEqual(firstConfig, newConfig)
    }
    
    func testResetShared() {
        let firstConfig = SilverMob.shared
        firstConfig.prebidServerAccountId = "test"
        SilverMob.reset()
        
        checkInitialValue(sdkConfiguration: firstConfig)
    }
    
    func testPrebidHost() {
        let sdkConfig = SilverMob.shared
        XCTAssertEqual(sdkConfig.prebidServerHost, .Custom)
        
        sdkConfig.prebidServerHost = .Appnexus
        XCTAssertEqual(try! Host.shared.getHostURL(host:sdkConfig.prebidServerHost), "https://ib.adnxs.com/openrtb2/prebid")
        
        let _ = try! SilverMob.shared.setCustomPrebidServer(url: "https://10.0.2.2:8000/openrtb2/auction")
        XCTAssertEqual(sdkConfig.prebidServerHost, .Custom)
    }
    
    func testServerHostCustomInvalid() throws {
        XCTAssertThrowsError(try SilverMob.shared.setCustomPrebidServer(url: "wrong url"))
    }
    
    func testServerHost() {
        //given
        let case1 = PrebidHost.Appnexus
        let case2 = PrebidHost.Rubicon
        
        //when
        SilverMob.shared.prebidServerHost = case1
        let result1 = SilverMob.shared.prebidServerHost
        
        SilverMob.shared.prebidServerHost = case2
        let result2 = SilverMob.shared.prebidServerHost
        
        //then
        XCTAssertEqual(case1, result1)
        XCTAssertEqual(case2, result2)
    }
    
    func testServerHostCustom() throws {
        //given
        let customHost = "https://prebid-server.rubiconproject.com/openrtb2/auction"
        
        //when
        //We can not use setCustomPrebidServer() because it uses UIApplication.shared.canOpenURL
//        try! Prebid.shared.setCustomPrebidServer(url: customHost)
        
        SilverMob.shared.prebidServerHost = PrebidHost.Custom
        try Host.shared.setCustomHostURL(customHost)
        
        //then
        XCTAssertEqual(PrebidHost.Custom, SilverMob.shared.prebidServerHost)
        let getHostURLResult = try Host.shared.getHostURL(host: .Custom)
        XCTAssertEqual(customHost, getHostURLResult)
    }
    
    func testAccountId() {
        //given
        let serverAccountId = "123"
        
        //when
        SilverMob.shared.prebidServerAccountId = serverAccountId
        
        //then
        XCTAssertEqual(serverAccountId, SilverMob.shared.prebidServerAccountId)
    }

    func testStoredAuctionResponse() {
        //given
        let storedAuctionResponse = "111122223333"
        
        //when
        SilverMob.shared.storedAuctionResponse = storedAuctionResponse
        
        //then
        XCTAssertEqual(storedAuctionResponse, SilverMob.shared.storedAuctionResponse)
    }
    
    func testAddStoredBidResponse() {
        
        //given
        let appnexusBidder = "appnexus"
        let appnexusResponseId = "221144"
        
        let rubiconBidder = "rubicon"
        let rubiconResponseId = "221155"
        
        //when
        SilverMob.shared.addStoredBidResponse(bidder: appnexusBidder, responseId: appnexusResponseId)
        SilverMob.shared.addStoredBidResponse(bidder: rubiconBidder, responseId: rubiconResponseId)
        
        //then
        let dict = SilverMob.shared.storedBidResponses
        XCTAssertEqual(2, dict.count)
        XCTAssert(dict[appnexusBidder] == appnexusResponseId && dict[rubiconBidder] == rubiconResponseId )
    }
    
    func testClearStoredBidResponses() {
        
        //given
        SilverMob.shared.addStoredBidResponse(bidder: "rubicon", responseId: "221155")
        let case1 = SilverMob.shared.storedBidResponses.count
        
        //when
        SilverMob.shared.clearStoredBidResponses()
        let case2 = SilverMob.shared.storedBidResponses.count
        
        //then
        XCTAssertNotEqual(0, case1)
        XCTAssertEqual(0, case2)
    }

    func testAddCustomHeader() {
        
        //given
        let sdkVersionHeader = "X-SDK-Version"
        let bundleHeader = "X-Bundle"

        let sdkVersion = "1.1.666"
        let bundleName = "com.app.nextAd"

        //when
        SilverMob.shared.addCustomHeader(name: sdkVersionHeader, value: sdkVersion)
        SilverMob.shared.addCustomHeader(name: bundleHeader, value: bundleName)

        //then
        let dict = SilverMob.shared.customHeaders
        XCTAssertEqual(2, dict.count)
        XCTAssert(dict[sdkVersionHeader] == sdkVersion && dict[bundleHeader] == bundleName )
    }

    func testClearCustomHeaders() {

        //given
        SilverMob.shared.addCustomHeader(name: "header", value: "value")
        let case1 = SilverMob.shared.customHeaders.count

        //when
        SilverMob.shared.clearCustomHeaders()
        let case2 = SilverMob.shared.customHeaders.count

        //then
        XCTAssertNotEqual(0, case1)
        XCTAssertEqual(0, case2)
    }
    
    func testShareGeoLocation() {
        //given
        let case1 = true
        let case2 = false
        
        //when
        SilverMob.shared.shareGeoLocation = case1
        let result1 = SilverMob.shared.shareGeoLocation
        
        SilverMob.shared.shareGeoLocation = case2
        let result2 = SilverMob.shared.shareGeoLocation
        
        //rhen
        XCTAssertEqual(case1, result1)
        XCTAssertEqual(case2, result2)
    }
    
    func testTimeoutMillis() {
        //given
        let timeoutMillis =  3_000
        
        //when
        SilverMob.shared.timeoutMillis = timeoutMillis
        
        //then
        XCTAssertEqual(timeoutMillis, SilverMob.shared.timeoutMillis)
    }
    
    func testBidderName() {
        XCTAssertEqual("appnexus", SilverMob.bidderNameAppNexus)
        XCTAssertEqual("rubicon", SilverMob.bidderNameRubiconProject)
    }
    
    func testPbsDebug() {
        //given
        let pbsDebug = true
        
        //when
        SilverMob.shared.pbsDebug = pbsDebug
        
        //then
        XCTAssertEqual(pbsDebug, SilverMob.shared.pbsDebug)
    }
    
    func testPBSCreativeFactoryTimeout() {
        try! sdkConfiguration.setCustomPrebidServer(url: SilverMob.devintServerURL)
        sdkConfiguration.prebidServerAccountId = SilverMob.devintAccountID
        
        let creativeFactoryTimeout = 11.1
        let creativeFactoryTimeoutPreRenderContent = 22.2
        
        let configId = "b6260e2b-bc4c-4d10-bdb5-f7bdd62f5ed4"
        let adUnitConfig = AdUnitConfig(configId: configId, size: CGSize(width: 300, height: 250))
        let connection = MockServerConnection(onPost: [{ (url, data, timeout, callback) in
            callback(PBMBidResponseTransformer.makeValidResponseWithCTF(bidPrice: 0.5, ctfBanner: creativeFactoryTimeout, ctfPreRender: creativeFactoryTimeoutPreRenderContent))
        }])
        
        let requester = PBMBidRequester(connection: connection,
                                        sdkConfiguration: sdkConfiguration,
                                        targeting: targeting,
                                        adUnitConfiguration: adUnitConfig)
        
        let exp = expectation(description: "exp")
        requester.requestBids { (bidResponse, error) in
            exp.fulfill()
            if let error = error {
                XCTFail(error.localizedDescription)
                return
            }
            XCTAssertNotNil(bidResponse)
        }
        waitForExpectations(timeout: 5)
        
        XCTAssertEqual(SilverMob.shared.creativeFactoryTimeout, creativeFactoryTimeout)
        XCTAssertEqual(SilverMob.shared.creativeFactoryTimeoutPreRenderContent, creativeFactoryTimeoutPreRenderContent)
    }
    
    // MARK: - Private Methods
    
    private func checkInitialValue(sdkConfiguration: SilverMob, file: StaticString = #file, line: UInt = #line) {
        // PBMSDKConfiguration
        
        XCTAssertEqual(sdkConfiguration.creativeFactoryTimeout, 6.0)
        XCTAssertEqual(sdkConfiguration.creativeFactoryTimeoutPreRenderContent, 30.0)
        
        XCTAssertFalse(sdkConfiguration.useExternalClickthroughBrowser)
        
        // Prebid-specific
        
        XCTAssertEqual(sdkConfiguration.prebidServerAccountId, "")
        XCTAssertEqual(sdkConfiguration.prebidServerHost, .Custom)
    }
}

/*   Copyright 2018-2019 Prebid.org, Inc.

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

#import <XCTest/XCTest.h>
#import "SilverMobSdk/SilverMobSdk.h"

@interface PrebidObjcTests : XCTestCase

@end

@implementation PrebidObjcTests

- (void)testServerHost {
    //given
    PrebidHost case1 = PrebidHostAppnexus;
    PrebidHost case2 = PrebidHostRubicon;
    
    //when
    SilverMob.shared.prebidServerHost = case1;
    PrebidHost result1 = SilverMob.shared.prebidServerHost;
    SilverMob.shared.prebidServerHost = case2;
    PrebidHost result2 = SilverMob.shared.prebidServerHost;
    
    //then
    XCTAssertEqual(case1, result1);
    XCTAssertEqual(case2, result2);
}


- (void)testAccountId {
    //given
    NSString *serverAccountId = @"123";
    
    //when
    SilverMob.shared.prebidServerAccountId = serverAccountId;
    
    //then
    XCTAssertEqualObjects(serverAccountId, SilverMob.shared.prebidServerAccountId);
}

- (void)testStoredAuctionResponse {
    //given
    NSString *storedAuctionResponse = @"111122223333";
    
    //when
    SilverMob.shared.storedAuctionResponse = storedAuctionResponse;
    
    //then
    XCTAssertEqualObjects(storedAuctionResponse, SilverMob.shared.storedAuctionResponse);
}

- (void)testAddStoredBidResponse {
    [SilverMob.shared addStoredBidResponseWithBidder:@"rubicon" responseId:@"221155"];
}

- (void)testClearStoredBidResponses {
    [SilverMob.shared clearStoredBidResponses];
}

- (void)testShareGeoLocation {
    //given
    BOOL case1 = YES;
    BOOL case2 = NO;
    
    //when
    SilverMob.shared.shareGeoLocation = case1;
    BOOL result1 = SilverMob.shared.shareGeoLocation;
    
    SilverMob.shared.shareGeoLocation = case2;
    BOOL result2 = SilverMob.shared.shareGeoLocation;
    
    //rhen
    XCTAssertEqual(case1, result1);
    XCTAssertEqual(case2, result2);
}

- (void)testTimeoutMillis {
    //given
    int timeoutMillis =  3000;
    
    //when
    SilverMob.shared.timeoutMillis = timeoutMillis;
    
    //then
    XCTAssertEqual(timeoutMillis, SilverMob.shared.timeoutMillis);
}

- (void)testLogLevel {
    [SilverMob.shared setLogLevel:PBMLogLevel.debug];
}

- (void)testBidderName {
    XCTAssertEqualObjects(@"appnexus", SilverMob.bidderNameAppNexus);
    XCTAssertEqualObjects(@"rubicon", SilverMob.bidderNameRubiconProject);
}

- (void)testPbsDebug {
    //given
    BOOL pbsDebug = true;
    
    //when
    SilverMob.shared.pbsDebug = pbsDebug;
    
    //then
    XCTAssertEqual(pbsDebug, SilverMob.shared.pbsDebug);
}

@end

//
//  VIMUserBadgeTests.swift
//  VimeoNetworkingExample-iOSTests
//
//  Created by Nguyen, Van on 12/12/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import VimeoNetworking

class VIMUserBadgeTests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
        
        VimeoClient.configureSharedClient(withAppConfiguration: AppConfiguration(clientIdentifier: "{CLIENT_ID}",
                                                                                 clientSecret: "{CLIENT_SECRET}",
                                                                                 scopes: [.Public, .Private, .Purchased, .Create, .Edit, .Delete, .Interact, .Upload],
                                                                                 keychainService: "com.vimeo.keychain_service",
                                                                                 apiVersion: "3.3.10"))
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        OHHTTPStubs.removeAllStubs()
    }
    
    private func stubResponse(withFile fileName: String)
    {
        stub(condition: isPath("/users/" + Constants.CensoredId)) { _ in
            let stubPath = OHPathForFile(fileName, type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
    
    private func checkReturnedBadgeType(withExpectedType expectedType: VIMUserBadgeType, andExpectation expectation: XCTestExpectation)
    {
        let request = Request<VIMUser>(path: "/users/" + Constants.CensoredId)
        
        _ = VimeoClient.sharedClient.request(request, completion: { (response) in
            switch response
            {
            case .success(let result):
                XCTAssertEqual(result.model.badge?.badgeType, expectedType)
                
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: 1.0)
    }
    
    func testUserObjectReturningBasicBadge()
    {
        self.stubResponse(withFile: "user_basic.json")
        let expectation = self.expectation(description: "Expectation for Basic Badge")
        self.checkReturnedBadgeType(withExpectedType: .default, andExpectation: expectation)
    }
    
    func testUserObjectReturningPlusBadge()
    {
        self.stubResponse(withFile: "user_plus.json")
        let expectation = self.expectation(description: "Expectation for Plus Badge")
        self.checkReturnedBadgeType(withExpectedType: .plus, andExpectation: expectation)
    }
    
    func testUserObjectReturningProBadge()
    {
        self.stubResponse(withFile: "user_pro.json")
        let expectation = self.expectation(description: "Expectation for Pro Badge")
        self.checkReturnedBadgeType(withExpectedType: .pro, andExpectation: expectation)
    }
    
    func testUserObjectReturningBusinessBadge()
    {
        self.stubResponse(withFile: "user_business.json")
        let expectation = self.expectation(description: "Expectation for Business Badge")
        self.checkReturnedBadgeType(withExpectedType: .business, andExpectation: expectation)
    }
    
    func testUserObjectReturningLiveBusinessBadge()
    {
        self.stubResponse(withFile: "user_live_business.json")
        let expectation = self.expectation(description: "Expectation for Live Business Badge")
        self.checkReturnedBadgeType(withExpectedType: .liveBusiness, andExpectation: expectation)
    }
    
    func testUserObjectReturningLiveProBadge()
    {
        self.stubResponse(withFile: "user_live_pro.json")
        let expectation = self.expectation(description: "Expectation for Live Pro Badge")
        self.checkReturnedBadgeType(withExpectedType: .livePro, andExpectation: expectation)
    }
    
    func testUserObjectReturningStaffBadge()
    {
        self.stubResponse(withFile: "user_staff.json")
        let expectation = self.expectation(description: "Expectation for Staff Badge")
        self.checkReturnedBadgeType(withExpectedType: .staff, andExpectation: expectation)
    }
    
    func testUserObjectReturningCurationBadge()
    {
        self.stubResponse(withFile: "user_curation.json")
        let expectation = self.expectation(description: "Expectation for Curation Badge")
        self.checkReturnedBadgeType(withExpectedType: .curation, andExpectation: expectation)
    }
    
    func testUserObjectReturningSupportBadge()
    {
        self.stubResponse(withFile: "user_support.json")
        let expectation = self.expectation(description: "Expectation for Support Badge")
        self.checkReturnedBadgeType(withExpectedType: .support, andExpectation: expectation)
    }
    
    func testUserObjectReturningAlumBadge()
    {
        self.stubResponse(withFile: "user_alum.json")
        let expectation = self.expectation(description: "Expectation for Alum Badge")
        self.checkReturnedBadgeType(withExpectedType: .alum, andExpectation: expectation)
    }
}

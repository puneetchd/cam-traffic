//
//  NetworkHandlerTests.swift
//  CamTrafficTests
//
//  Created by Puneet Sharma on 8/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import XCTest

class NetworkHandlerTests: XCTestCase {

    let networkHandler = BaseNetworkAPI.shared
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testNetworkRequestCreation() {
        
    }
    
    func testBadURLResponse() {
        let requestModel: NetworkRequestModel = NetworkRequestModel(requestType: NetworkRequestType.get, url: "\(kBaseUrl)/transport/traffic-images", parameters: ["date_time":"forDate"], headers: nil)
        networkHandler.createRequest(networkRequestModel: requestModel) { (data, error) in
            XCTAssertEqual(error, NetworkError.apiError, "API Error should have occured")
        }
    }

    override func tearDown() {
       
    }
}

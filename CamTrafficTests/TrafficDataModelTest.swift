//
//  TrafficDataModelTest.swift
//  CamTrafficTests
//
//  Created by Puneet Sharma on 8/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import XCTest

class TrafficDataModelTest: XCTestCase {
    
    //MARK:- Variables
    var trafficData: DataTraffic!

    override func setUp() {
        trafficData = DataTraffic(rootItem: [DataTraffic.ItemsList(camerasList: [DataTraffic.ItemsList.DataTrafficCamera(imageURL: URL(string: "https://images.data.gov.sg/api/traffic-images/2020/01/d50a5c10-6461-4874-bb8f-0df978083379.jpg"), locationCoordinate: ["latitude":1.28569398886979, "longitude":103.837524510188])])])
    }
    
    func testImageURL() {
        let imageURL: URL? = trafficData.rootItem?.first?.camerasList?.first?.imageURL
        if let imageURL: String = imageURL?.absoluteString {
            XCTAssertEqual(imageURL, "https://images.data.gov.sg/api/traffic-images/2020/01/d50a5c10-6461-4874-bb8f-0df978083379.jpg", "Invalid image url")
        } else {
            XCTAssertNotNil(imageURL, "Invalid image url")
        }
    }
    
    func testLocationCoordinate() {
        let coord = trafficData.rootItem?.first?.camerasList?.first?.getLocationCoord()
        XCTAssertNotNil(coord, "Location Coordinate Not set properly")
    }

    override func tearDown() {
        trafficData = nil
    }
}

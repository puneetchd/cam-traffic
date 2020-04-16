//
//  TrafficMapViewModelTest.swift
//  CamTrafficTests
//
//  Created by Puneet Sharma on 8/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import XCTest

class TrafficMapViewModelTest: XCTestCase {

    //MARK:- Variables
    var trafficMapViewModel: TrafficMapViewModel!
    
    override func setUp() {
        trafficMapViewModel = TrafficMapViewModel(apiHandler: MockTrafficAPIHandler())
    }
    
    //MARK: TrafficMapViewModel
    func testTrafficDataFetch() {
        let promise: XCTestExpectation = expectation(description: "fetched Objects count > 0")
        trafficMapViewModel.callbackHandler = {(callbackType: Callback) in
            switch callbackType {
            case .showError(let error):
                XCTFail(error.localizedDescription)
            case .reloadContent:
                promise.fulfill()
            default:
                break
            }
        }

        XCTAssertNil(self.trafficMapViewModel.dataTraffic?.rootItem?.first?.camerasList?.count, "Results should be empty before the data task runs")
        trafficMapViewModel.fetchTrafficCameraData()
        wait(for: [promise], timeout: 2)
        XCTAssertEqual(self.trafficMapViewModel.dataTraffic?.rootItem?.first?.camerasList?.count , 87, "Unable to parse all objects")
    }
    
    func testAnnotationForMapView() {
        trafficMapViewModel.fetchTrafficCameraData()
        XCTAssertEqual(trafficMapViewModel.getAnnotationToDsiplayOnMap()?.count, 87, "Unable to get annotations for displaying on map")
    }

    override func tearDown() {
        trafficMapViewModel = nil
    }
}

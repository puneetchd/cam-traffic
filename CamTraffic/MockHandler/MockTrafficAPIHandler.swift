//
//  MockTrafficAPIHandler.swift
//  CamTraffic
//
//  Created by Puneet Sharma on 8/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

class MockTrafficAPIHandler: TrafficAPIProtocol {
    //Mock Traffic handler.
    func getLatestTraffic(forDate: String, completionHandler: @escaping TrafficDataCompletionHandler) {
        if let path = Bundle.main.path(forResource: "MockTrafficDataResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder: JSONDecoder = JSONDecoder()
                let models: DataTraffic = try decoder.decode(
                    DataTraffic.self,
                    from:
                        data)
                completionHandler(models, nil)
            } catch let parsingError {
                completionHandler(nil, .genericError(code: 11, message: parsingError.localizedDescription))
            }
        }
    }

}

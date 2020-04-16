//
//  BaseNetworkHelper.swift
//  CamTrafficAssignment
//
//  Created by Puneet Sharma on 6/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

let kBaseUrl = "https://api.data.gov.sg/v1"

class BaseTrafficAPIHandler : TrafficAPIProtocol {
    
    private let networkHandler = BaseNetworkAPI.shared
    
    func getLatestTraffic(forDate: String, completionHandler: @escaping TrafficDataCompletionHandler) {
        
        let requestModel: NetworkRequestModel = NetworkRequestModel(requestType: NetworkRequestType.get, url: "\(kBaseUrl)/transport/traffic-images", parameters: ["date_time":forDate], headers: nil)
        
        networkHandler.createRequest(networkRequestModel: requestModel) { (data, networkError) in
            if let dataResponse: Data = data {
                do {
                    let decoder: JSONDecoder = JSONDecoder()
                    let models: DataTraffic = try decoder.decode(DataTraffic.self, from:
                        dataResponse)
                    completionHandler(models, nil)
                } catch let parsingError {
                    completionHandler(nil, .genericError(code: 11, message: parsingError.localizedDescription))
                }
            }else{
                completionHandler(nil, networkError)
            }
        }
    }

}

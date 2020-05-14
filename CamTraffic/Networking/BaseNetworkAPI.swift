//
//  BaseNetworkAPI.swift
//  CamTrafficAssignment
//
//  Created by Puneet Sharma on 6/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

struct NetworkRequestModel {
    let requestType: NetworkRequestType
    let url: String
    var parameters: [AnyHashable: Any]?
    var headers: [String: String]?
}

class BaseNetworkAPI {

    public static let shared = BaseNetworkAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = JSONDecoder()

    //MARK:- Configure session parameters
    fileprivate let defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60.0
        configuration.timeoutIntervalForResource = 60.0
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    /**
    Create an API request based on required needs.
    
    - parameter networkRequestModel: A NetworkRequestModel type struct holding details of request.
    - parameter completion: This is an escaping completion block which will notify client about status of request once its executed, of type `(_ data: Data?, _ error: NetworkError?)`
    */
    func createRequest(networkRequestModel: NetworkRequestModel, completion: @escaping NetworkAPIHandler) {

        guard let url: URL = URL(string: networkRequestModel.url)
        else {
            completion(nil, .invalidEndpoint)
            return
        }

        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = networkRequestModel.requestType.rawValue

        if let headers: [String: String] = networkRequestModel.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        if networkRequestModel.requestType == .post, let reqParamaters: [AnyHashable: Any] = networkRequestModel.parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: reqParamaters, options: .prettyPrinted)
            } catch _ {
                completion(nil, .apiError)
                return
            }
        }

        defaultSession.dataTask(with: urlRequest) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    do {
                        let responseBody = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        completion(nil, .genericError(code: 10, message: responseBody?["message"] as? String ?? "Server error occured"))
                    } catch {
                        completion(nil, .invalidEndpoint)
                    }
                    return
                }

                if let responseData: Data = data {
                    completion(responseData, nil)
                } else {
                    completion(nil, .noData)
                }
            case .failure(let error):
                if (error as NSError).domain == NSURLErrorDomain && (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    completion(nil, .noInternet)
                } else {
                    completion(nil, .apiError)
                }
            }
        }.resume()
    }
}

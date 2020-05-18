//
//  NetworkError.swift
//  CamTrafficAssignment
//
//  Created by Puneet Sharma on 6/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

enum NetworkError: Error, Equatable {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
    case noInternet
    case genericError(code: Int, message: String)

    var localizedDescription: String {
        switch self {
        case .genericError(_, let message):
            return message
        case .apiError:
            return "Invalid API Request"
        case .invalidResponse:
            return "API returned something that wasn't JSON"
        case .noData:
            return "No data was returned from the webserver"
        case .decodeError:
            return "JSON Decoding Failed"
        case .invalidEndpoint:
            return "Requested API endpoint is invalid"
        case .noInternet:
            return "The Internet connection appears to be offline."
        }
    }
}

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
    
    /// Returns any of the `NetworkError` enum value based on the given error code
    /// - Parameters:
    ///    - errorCode: API Response Code
    /// - Returns: Any type of `XINGNetworkError`
    /*
    static func getErrorType(fromErrorCode errorCode: Int) -> NetworkError {
        switch errorCode {
        case 100..<200: return .unavailable
        case 200..<300: return .success
        case 300..<400: return .redirection
        case 400..<500: return .clientError
        case 500..<600: return .serverError
        default: return .unknown
        }
    }
     */
}



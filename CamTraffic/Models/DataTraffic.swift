//
//  DataTraffic.swift
//  CamTrafficAssignment
//
//  Created by Puneet Sharma on 6/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import CoreLocation
import Foundation

struct DataTraffic: Decodable {

    var rootItem: [ItemsList]?

    enum CodingKeys: String, CodingKey {
        case rootItem = "items"
    }

    struct ItemsList: Decodable {
        var camerasList: [DataTrafficCamera]?

        enum CodingKeys: String, CodingKey {
            case camerasList = "cameras"
        }

        struct DataTrafficCamera: Decodable {
            var imageURL: URL?
            var locationCoordinate: [String: Double]?

            enum CodingKeys: String, CodingKey {
                case imageURL = "image"
                case locationCoordinate = "location"
            }

            func getLocationCoord() -> CLLocationCoordinate2D {
                var formattedCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
                if let locaCL = locationCoordinate {
                    formattedCoord = CLLocationCoordinate2D(latitude: locaCL["latitude"] ?? 0.0, longitude: locaCL["longitude"] ?? 0.0)
                }
                return formattedCoord
            }
        }
    }
}

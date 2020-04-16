//
//  TrafficAPIProtocol.swift
//  CamTrafficAssignment
//
//  Created by Puneet Sharma on 7/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation

protocol TrafficAPIProtocol {
    func getLatestTraffic(forDate:String, completionHandler: @escaping TrafficDataCompletionHandler)
}

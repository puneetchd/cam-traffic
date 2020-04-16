//
//  TrafficMapViewModel.swift
//  CamTrafficAssignment
//
//  Created by Puneet Sharma on 6/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation
import MapKit

class TrafficMapViewModel {
    
    private let networkHandler: TrafficAPIProtocol
    var callbackHandler: CallbackHandler?
    var dataTraffic: DataTraffic?
    
    //MARK:- Init Methods
    init(apiHandler: TrafficAPIProtocol) {
        networkHandler = apiHandler
    }
    
    func fetchTrafficCameraData() {
        callbackHandler?(Callback.showLoader)
        networkHandler.getLatestTraffic(forDate: getJSONDateFormatStringForToday()) { [weak self] (trafficModel, networkError) in
            if let err = networkError {
                self?.callbackHandler?(Callback.showError(error: err))
            } else {
                self?.dataTraffic = trafficModel
                self?.callbackHandler?(Callback.reloadContent)
            }
            self?.callbackHandler?(Callback.hideLoader)
        }
    }
    
    func getAnnotationToDsiplayOnMap() -> [MKPointAnnotation]? {
        guard let listOfAnnotations = dataTraffic?.rootItem?.first?.camerasList?.map({ (obj) -> MKPointAnnotation in
            let customAnnotation = CustomAnnotationView()
            customAnnotation.coordinate = obj.getLocationCoord()
            customAnnotation.trafficLargeImageURL = obj.imageURL
            return customAnnotation
        }) else { return [] }
        return listOfAnnotations
    }
    
    func getJSONDateFormatStringForToday() -> String {
        let dateFormater : DateFormatter = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormater.string(from: Date())
    }
}

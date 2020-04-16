//
//  ViewController.swift
//  CamTrafficAssignment
//
//  Created by Puneet Sharma on 6/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import UIKit
import MapKit

class CameraMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let viewModel: TrafficMapViewModel = TrafficMapViewModel(apiHandler: BaseTrafficAPIHandler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        self.title = "MapView"
        addHandlers()
        viewModel.fetchTrafficCameraData()
    }
    
    private func addHandlers() {
        viewModel.callbackHandler = { [weak self] (callbackType: Callback) in
            if let weakSelf: CameraMapViewController = self {
                DispatchQueue.main.async {
                    switch callbackType {
                    case .showLoader:
                        weakSelf.title = "Updating..."
                    case .hideLoader:
                        weakSelf.title = "Updated MapView"
                    case .reloadContent:
                        weakSelf.updateMapView()
                    case .showError(let error):
                        showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: weakSelf)
                    }
                }
            }
        }
    }
    
    func updateMapView() {
        mapView.addAnnotations(viewModel.getAnnotationToDsiplayOnMap()!)
    }
}

extension CameraMapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let cameraSnapVC = self.storyboard?.instantiateViewController(withIdentifier: "CameraSnapVCIdentifier") as! CameraSnapViewController
        cameraSnapVC.modalPresentationStyle = .overCurrentContext
        cameraSnapVC.modalPresentationCapturesStatusBarAppearance = true
        cameraSnapVC.imageURLToLoad = (view.annotation as? CustomAnnotationView)?.trafficLargeImageURL
        self.navigationController?.present(cameraSnapVC, animated: true, completion: {
            
        })
    }
}

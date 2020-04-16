//
//  CameraSnapViewController.swift
//  CamTraffic
//
//  Created by Puneet Sharma on 8/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import UIKit

class CameraSnapViewController: UIViewController {

    @IBOutlet weak var cameraImageView: UIImageView!
    var imageURLToLoad:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGasture = UITapGestureRecognizer(target: self, action: #selector(selfViewTapped))
        view.addGestureRecognizer(tapGasture)
        cameraImageView.loadImageUsingCache(withUrl: imageURLToLoad.absoluteString)
    }
    
    @objc func selfViewTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

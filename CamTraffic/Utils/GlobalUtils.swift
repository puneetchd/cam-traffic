//
//  GlobalUtils.swift
//  CamTraffic
//
//  Created by Puneet Sharma on 8/1/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation
import UIKit

func showAlertControllerWithError(forErrorMessage: String?, forViewController: UIViewController) {
    let alert = UIAlertController(
        title: NSLocalizedString("Error", comment: ""), message: (forErrorMessage?.isEmpty == true) ? "Error occurred" : forErrorMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
    DispatchQueue.main.async {
        forViewController.present(alert, animated: true, completion: nil)
    }
}

//
//  UIAlertController.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 11/24/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func create(parent: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        parent.present(alert, animated: true)
    }
}

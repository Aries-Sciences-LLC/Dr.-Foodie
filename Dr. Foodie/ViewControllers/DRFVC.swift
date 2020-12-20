//
//  DRFVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 12/16/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

class DRFVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = UIApplication.shared.hasTopNotch ? 42 : 10
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 0.25
        
        let width = UIScreen.main.bounds.width - 1
        let height = UIScreen.main.bounds.height - 1
        view.frame.size = CGSize(width: width, height: height)
    }
}

//
//  UIApplication.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 12/7/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

extension UIApplication {
    func isFirstLaunch() -> Bool {
        if !UserDefaults.standard.bool(forKey: "HasLaunched") {
            UserDefaults.standard.set(true, forKey: "HasLaunched")
            return true
        }
        return false
    }
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return self.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

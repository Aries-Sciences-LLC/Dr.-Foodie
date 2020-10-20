//
//  Double.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/18/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

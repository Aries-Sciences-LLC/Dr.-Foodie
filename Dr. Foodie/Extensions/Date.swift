//
//  Date.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/16/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation

extension Date {
    static func today() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: Date())
    }
    
    func convertTo12hour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
    
    func convertToMonthDayCombination() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: self)
    }
}

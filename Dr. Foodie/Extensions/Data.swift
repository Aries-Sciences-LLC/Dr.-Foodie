//
//  Data.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 12/20/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation

extension Data {
    func unwrap() -> User {
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: User.self, from: self)!
        } catch {
            return User.zero
        }
    }
}

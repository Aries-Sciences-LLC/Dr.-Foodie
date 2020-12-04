//
//  Data.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/11/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation
import AudioToolbox

extension NSObject {
    func pop() {
        AudioServicesPlaySystemSound(1520)
    }
    
    func bytes() -> Data {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        } catch {
            print(error)
            return Data()
        }
    }
}

extension Data {
    func unwrap() -> User {
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: User.self, from: self)!
        } catch {
            return User.zero
        }
    }
}

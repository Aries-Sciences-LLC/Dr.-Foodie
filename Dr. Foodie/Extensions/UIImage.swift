//
//  UIImage.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/16/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import CloudKit

extension UIImage {
    func cloud() -> CKAsset? {
        if let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString + ".dat") {
            do {
                try pngData()!.write(to: url)
            } catch let e as NSError {
                print("Error! \(e)")
            }
            return CKAsset(fileURL: url)
        }
        return nil
    }
}

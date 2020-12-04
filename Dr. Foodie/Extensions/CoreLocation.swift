//
//  Maps.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 11/24/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import CoreLocation

extension CLLocationCoordinate2D {
    func equals(_ coordinate: CLLocationCoordinate2D) -> Bool {
        return coordinate.latitude == latitude && coordinate.longitude == longitude
    }
}

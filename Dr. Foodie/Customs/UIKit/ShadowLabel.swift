//
//  ShadowLabel.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 1/13/21.
//  Copyright © 2021 Aries Sciences LLC. All rights reserved.
//

import UIKit

class ShadowLabel: UILabel {

    override func didMoveToSuperview() {
        layer.shadowColor = textColor.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.92
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        layer.shadowColor = textColor.cgColor
    }
}

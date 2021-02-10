//
//  PlaceholderCollectionViewCell.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 1/8/21.
//  Copyright © 2021 Aries Sciences LLC. All rights reserved.
//

import UIKit

class PlaceholderCollectionViewCell: UICollectionViewCell {
    var handler: (() -> Void)?
    
    @IBAction func pressed(_ sender: UIButton!) {
        handler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 17
        layer.shadowOpacity = 1
        
        contentView.subviews.first?.layer.cornerRadius = 5
        contentView.subviews.first?.layer.masksToBounds = true
        contentView.subviews.first?.layer.borderWidth = 0.4
        contentView.subviews.first?.layer.borderColor = UIColor.label.cgColor
    }
}

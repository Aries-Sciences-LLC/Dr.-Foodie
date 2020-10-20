//
//  CategoryCell.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/17/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Properties, IBOutlets, & IBActions
class CategoryCell: UICollectionViewCell {
    private(set) var enabled: Bool = false
    
    @IBOutlet weak var titleLbl: UILabel!
    
    public var indexPath: IndexPath?
    public var onSwitched: ((Bool) -> Void)?
    
    @IBAction func selected() {
        enabled = !enabled
        onSwitched?(enabled)
        
        UIView.animate(withDuration: 0.3) {
            switch self.enabled {
            case true:
                self.contentView.backgroundColor = UIColor(named: "TabItemTintColor")!.withAlphaComponent(0.7)
            case false:
                self.contentView.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
            }
        }
    }
}

// MARK: Methods
extension CategoryCell {
    public func set(category: String) {
        titleLbl.text = category
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        UIView.animate(withDuration: 0.3) {
            self.contentView.alpha = 1
        }
    }
}

//
//  RestaurantCategoryCell.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: RestaurantCategoryCellDelegate
protocol RestaurantCategoryCellDelegate {
    func categoryWasDeleted(with title: String)
}

// MARK: Properties, IBOutlets, IBActions
class RestaurantCategoryCell: UICollectionViewCell {
    var delegate: RestaurantCategoryCellDelegate?
    
    @IBOutlet weak var category: UILabel!
    
    @IBAction func deleteCategory(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.delegate?.categoryWasDeleted(with: self.category.text!)
        }
    }
}

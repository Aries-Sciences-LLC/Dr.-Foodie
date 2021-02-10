//
//  EditCell.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: EditCellDelegate
protocol EditCellDelegate {
    func displayEditor()
    func finishedEditing()
}

// MARK: Properties & IBActions
class EditCell: UICollectionReusableView {
    
    var delegate: EditCellDelegate?
    
    @IBAction func activated(_ sender: Any) {
        delegate?.displayEditor()
    }
}

// MARK: UITextFieldDelegate
extension EditCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let category = textField.text {
            if !category.isEmpty {
                RestaurantCategories.add(with: category)
            }
            textField.resignFirstResponder()
            delegate?.finishedEditing()
        }
        
        return false
    }
}


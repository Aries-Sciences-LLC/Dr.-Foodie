//
//  QuickAddItem.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/12/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: IBOutlets, INInspectables, Properties, & IBActions
class QuickAddItem: UICollectionViewCell {
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var listener: UIButton!
    
    private var handler: (() -> Void)?
    
    @IBAction func create(_ sender: UIButton!) {
        sender.isEnabled = false
        pop()
        UIView.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.15, animations: {
                self.transform = .identity
            }) { _ in
                self.handler?()
            }
        }
    }
}

// MARK: Methods
extension QuickAddItem {
    override func didMoveToSuperview() {
        UIView.animate(withDuration: 0.3, delay: 0.15 * Double(tag), options: .allowUserInteraction, animations: {
            self.contentView.alpha = 1
        }, completion: nil)
    }
    
    public func insert(item: QuickAddContainer, with completion: @escaping () -> Void) {
        itemImage.image = item.itemImage
        itemName.text = item.itemName
        handler = completion
    }
}

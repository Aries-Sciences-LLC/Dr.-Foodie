//
//  UIButton.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/5/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

extension UIButton {
    func space(with constant: CGFloat) {
        let spacing = (titleLabel!.intrinsicContentSize.width + imageView!.intrinsicContentSize.width + constant)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing + (titleLabel!.intrinsicContentSize.width / 2) + constant, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing - (titleLabel!.intrinsicContentSize.width / 2) - constant)
        self.layoutIfNeeded()
    }
    
    func indicate(with spaces: [CGFloat], for timing: Int) {
        let spacing = (titleLabel!.intrinsicContentSize.width + imageView!.intrinsicContentSize.width + spaces[timing])
        imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing + (titleLabel!.intrinsicContentSize.width / 2) + spaces[timing], bottom: 0, right: 0)
        
        UIView.animate(withDuration: 0.6, animations: {
            self.layoutIfNeeded()
        }) { _ in
            self.indicate(with: spaces, for: timing == 0 ? 1 : 0)
        }
    }
}

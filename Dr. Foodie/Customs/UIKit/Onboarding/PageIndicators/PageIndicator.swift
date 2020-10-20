//
//  PageIndicator.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Properties
class PageIndicator: UIView {

    internal var index: Int? = nil
    
    internal let size: CGFloat = 5
    internal let growthFactor: CGFloat = 7
    internal let spacing: CGFloat = 40
    internal let animationDuration: CGFloat = 0.3
}

// MARK: Methods
extension PageIndicator {
    open func createFor(index: Int) {
        self.index = index
        
        backgroundColor = UIColor(named: "PageIndicatorColor")
        layer.cornerRadius = size / 2
        
        snp.makeConstraints { (make) in
            make.height.equalTo(size)
            make.width.equalTo(size).offset(index == 0 ? size * growthFactor : size)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(index != 0 ? Int(spacing) * index : 0)
        }
    }
    
    open func moveRight() {
        index! += 1
        update()
    }
    
    open func moveLeft() {
        index! -= 1
        update()
    }
    
    internal func update() {
        snp.updateConstraints { (make) in
            make.width.equalTo(size).offset(index == 0 ? size * growthFactor : size)
            make.centerX.equalToSuperview().offset(index == 0 ? 0 : Int(spacing) * index!)
        }
    }
}

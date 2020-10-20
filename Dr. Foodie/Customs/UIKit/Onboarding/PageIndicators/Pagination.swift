//
//  PageInitation.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Properties
class Pagination: UIView {
    
    internal var beginningPage: Int = 0
}

// MARK: Methods
extension Pagination {
    open func addPage() {
        addSubview(PageIndicator())
        (subviews.last! as! PageIndicator).createFor(index: subviews.count - 1)
    }
    
    open func setInitialPage(to index: Int) {
        if beginningPage < index {
            var buffer = beginningPage
            for page in subviews {
                if (buffer != index) {
                    (page as! PageIndicator).moveRight()
                    buffer += 1
                } else {
                    break
                }
            }
        } else {
            var buffer = beginningPage
            for page in subviews {
                if (buffer != index) {
                    (page as! PageIndicator).moveLeft()
                    buffer -= 1
                } else {
                    break
                }
            }
        }
        
        beginningPage = index
    }
    
    open func swipeRight() -> Bool {
        if (subviews.last! as! PageIndicator).index! < subviews.count - 1 {
            for page in subviews {
                (page as! PageIndicator).moveRight()
            }
            return true
        }
        return false
    }
    
    open func swipeLeft() -> Bool {
        if (subviews.last! as! PageIndicator).index! > 0 {
            for page in subviews {
                (page as! PageIndicator).moveLeft()
            }
            return true
        }
        return false
    }
}

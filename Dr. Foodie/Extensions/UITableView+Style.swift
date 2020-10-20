//
//  UITableView+Style.swift
//  CircularCarousel Demo
//
//  Created by Piotr Suwara on 2/2/19.
//  Copyright © 2019 Piotr Suwara. All rights reserved.
//

import UIKit

extension UITableView {
    enum DetailStyle {
        case carousel
        case primary
    }
    
    func style(withDetail style: UITableView.DetailStyle) {
        switch style {
        case .carousel:
            separatorColor = ViewConstants.Colors.tableViewSeperator
            cellLayoutMarginsFollowReadableWidth = false
            isScrollEnabled = false
            allowsSelection = false
            
        case .primary:
            separatorColor = ViewConstants.Colors.tableViewSeperator
            cellLayoutMarginsFollowReadableWidth = false
            backgroundColor = .clear
            allowsSelection = false
        }
    }

    public var boundsWithoutInset: CGRect {
        var boundsWithoutInset = bounds
        boundsWithoutInset.origin.y += contentInset.top
        boundsWithoutInset.size.height -= contentInset.top + contentInset.bottom
        return boundsWithoutInset
    }

    public func isRowCompletelyVisible(at indexPath: IndexPath) -> Bool {
        let rect = rectForRow(at: indexPath)
        return boundsWithoutInset.contains(rect)
    }
}

//
//  TableCarouselView.swift
//  CircularCarousel Demo
//
//  Created by Piotr Suwara on 19/1/19.
//  Copyright © 2019 Piotr Suwara. All rights reserved.
//

import UIKit
import CircularCarousel
import SnapKit

protocol TableCarouselViewDelegate {
    func numberOfItems(inTableCarousel tableCarouselView: TableCarouselView) -> Int
}

final class TableCarouselView: UITableViewCell,
    CircularCarouselDelegate,
    CircularCarouselDataSource {
    
    var delegate: TableCarouselViewDelegate?
    var views: [UIView]?
    
    weak var _carousel : CircularCarousel!
    @IBOutlet var carousel : CircularCarousel! {
        set {
            _carousel = newValue
            _carousel.delegate = self
            _carousel.dataSource = self
        }
        
        get {
            return _carousel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: -
    // MARK: CircularCarouselDataSource
    
    func numberOfItems(inCarousel carousel: CircularCarousel) -> Int {
        return delegate?.numberOfItems(inTableCarousel: self) ?? 0
    }
    
    func carousel(_: CircularCarousel, viewForItemAt indexPath: IndexPath, reuseView view: UIView?) -> UIView {
        return views?[indexPath.item] ?? view ?? UIView()
    }
    
    // MARK: -
    // MARK: CircularCarouselDelegate
    func carousel(_ carousel: CircularCarousel, valueForOption option: CircularCarouselOption, withDefaultValue defaultValue: Int) -> Int {
        if option == .itemWidth {
            return Int(carousel.bounds.width)
        }
        
        return defaultValue
    }
}

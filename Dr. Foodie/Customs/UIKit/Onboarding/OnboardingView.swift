//
//  OnboardingView.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/16/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import SnapKit

// MARK: Properties & Overriding Methods
class OnboardingView: UIView {

    open var dataSource: OnboardingViewDataSource? = nil {
        didSet {
            createBoards()
            createPagination()
        }
    }
    
    internal let pagination: Pagination = Pagination()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        create()
    }
    
    internal func create() {
        self.layer.maskedCorners = [.layerMaxXMaxYCorner]
        self.layer.masksToBounds = true
    }
}

// MARK: Methods
extension OnboardingView {
    internal func createBoards() {
        for index in 0..<dataSource!.onboardingDataCount() {
            let data = dataSource!.getOnboardingData(for: index)
            
            addSubview(OnboardingBoard())
            (subviews.last! as! OnboardingBoard).create(with: data, at: index)
        }
    }
    
    internal func createPagination() {
        for _ in 0..<dataSource!.onboardingDataCount() {
            pagination.addPage()
        }
        pagination.setInitialPage(to: dataSource!.onboardingInitialPage())
        self.addSubview(pagination)
        pagination.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().multipliedBy(0.75)
        }
    }
}

// MARK: Swipe Recognizer Gestures
extension OnboardingView {
    open func skip() {
        while pagination.swipeLeft() {
            subviews.forEach { (subview) in
                if let board = subview as? OnboardingBoard {
                    if board.move(towards: .left) {
                        dataSource!.userFinishedOnboardingExperience()
                    }
                }
            }
            updatePages()
        }
    }
    
    open func moveRight() -> Bool {
        if pagination.swipeRight() {
            subviews.forEach { (subview) in
                if let board = subview as? OnboardingBoard {
                    _ = board.move(towards: .right)
                }
            }
            dataSource!.userReversed()
            updatePages()
            
            return true
        }
        
        return false
    }
    
    open func moveLeft() -> Bool {
        if pagination.swipeLeft() {
            subviews.forEach { (subview) in
                if let board = subview as? OnboardingBoard {
                    if board.move(towards: .left) {
                        dataSource!.userFinishedOnboardingExperience()
                    }
                }
            }
            updatePages()
            
            return true
        }
        
        return false
    }
    
    internal func updatePages() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .allowAnimatedContent, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}

//
//  OnboardingItemInfo.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Onboarding Data
struct OnboardingItemInfo {
    public var pageImage: UIImage?
    
    public var titleText: String
    public var descriptionText: String
    
    public var titleFont: UIFont
    public var descriptionFont: UIFont
    
    public var titleColor: UIColor
    public var descriptionColor: UIColor
    
    public init(
        pageImage: UIImage?,
        
        titleText: String,
        descriptionText: String,
        
        titleFont: UIFont,
        descriptionFont: UIFont,
        
        titleColor: UIColor,
        descriptionColor: UIColor
    ) {
        self.pageImage = pageImage
        
        self.titleText = titleText
        self.descriptionText = descriptionText
        
        self.titleFont = titleFont
        self.descriptionFont = descriptionFont
        
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
    }
}

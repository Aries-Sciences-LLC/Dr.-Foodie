//
//  OnboardingViewDataSource.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation

// MARK: Data Source
protocol OnboardingViewDataSource {
    func getOnboardingData(for index: Int) -> OnboardingItemInfo
    func onboardingDataCount() -> Int
    func onboardingInitialPage() -> Int
    func userFinishedOnboardingExperience()
    func userReversed()
}

//
//  OnBoardingViewController.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/14/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Properties, Child Controller Handlers, & Swipe Gesture Recognizers
class OnboardingVC: DRFVC {
    
    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var finishedButton: UIButton!
    @IBOutlet weak var overlay: UIVisualEffectView!
    
    @IBOutlet weak var backButtonLocation: NSLayoutConstraint!
    
    fileprivate let items: [OnboardingItemInfo] = [
        OnboardingItemInfo(
            pageImage: #imageLiteral(resourceName: "OnboardingPage1"),
            titleText: "No One Else Will See Your Data",
            descriptionText: "This app works very closely with your iCloud to ensure protection of data and work with your Health app.",
            titleFont: titleFont,
            descriptionFont: descriptionFont,
            titleColor: titleColor,
            descriptionColor: descriptionColor
        ),
        OnboardingItemInfo(
             pageImage: #imageLiteral(resourceName: "OnboardingPage2"),
             titleText: "Works Seamlessly",
             descriptionText: "Whether it is snapping a picture of your food, or looking at what Vitamins you might need today, or finding a healthy local, verified restraunt for lunch.",
             titleFont: titleFont,
             descriptionFont: descriptionFont,
             titleColor: titleColor,
             descriptionColor: descriptionColor
        ),
        OnboardingItemInfo(
             pageImage: #imageLiteral(resourceName: "OnboardingPage3"),
             titleText: "Your Body Will Thank You",
             descriptionText: "Afterall, in the most efficient and easy way, your mindset and diet will change for the better.",
             titleFont: titleFont,
             descriptionFont: descriptionFont,
             titleColor: titleColor,
             descriptionColor: descriptionColor
        ),
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ((segue.destination as! UINavigationController).topViewController as! LoginVC).cancelHandler = {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.overlay.alpha = 0
                }
            }
        }
    }
    
    @IBAction func swipedRight(_ sender: Any) {
        if onboardingView.moveRight() {
            view.constraints.forEach { (constraint) in
                if constraint.identifier == "background.x" {
                    constraint.constant += view.frame.width
                }
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func swipedLeft(_ sender: Any) {
        if onboardingView.moveLeft() {
            view.constraints.forEach { (constraint) in
                if constraint.identifier == "background.x" {
                    constraint.constant -= view.frame.width
                }
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func skipExperience(_ sender: Any) {
        onboardingView.skip()
    }
    
    @IBAction func presentingAuthorization(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.overlay.alpha = 1
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Actions
extension OnboardingVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Do any additional setup after loading the view.
        
        onboardingView.dataSource = self
        
        backButtonLocation.constant = 30
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: OnboardingViewDataSource
extension OnboardingVC: OnboardingViewDataSource {
    func getOnboardingData(for index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingDataCount() -> Int {
        return items.count
    }
    
    func onboardingInitialPage() -> Int {
        return 0
    }
    
    func userFinishedOnboardingExperience() {
        UIView.animate(withDuration: 0.3) {
            self.skipButton.alpha = 0
        }
        UIView.animate(withDuration: 0.3, delay: 0.15, options: .allowUserInteraction, animations: {
            self.finishedButton.alpha = 1
        }, completion: nil)
    }
    
    func userReversed() {
        UIView.animate(withDuration: 0.15) {
            self.finishedButton.alpha = 0
        }
        UIView.animate(withDuration: 0.3, delay: 0.075, options: .allowUserInteraction, animations: {
            self.skipButton.alpha = 1
        }, completion: nil)
    }
}

//MARK: Constants
private extension OnboardingVC {
    static let titleFont = UIFont(name: "Futura-Bold", size: 22)!
    static let descriptionFont = UIFont(name: "Futura-Medium", size: 12)!
    static let titleColor = UIColor(named: "LabelColor")!
    static let descriptionColor = UIColor(named: "SecondaryLabelColor")!
}

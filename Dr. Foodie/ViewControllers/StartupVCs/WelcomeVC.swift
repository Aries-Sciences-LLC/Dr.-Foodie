//
//  WelcomeViewController.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/26/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: IBOutlets & IBActions
class WelcomeVC: DRFVC {

    @IBOutlet weak var welcomeBackground: UIImageView!
    @IBOutlet weak var placeholder: UIVisualEffectView!
    @IBOutlet weak var replacer: UIVisualEffectView!
    @IBOutlet weak var loadingAnimator: UILabel!
    @IBOutlet weak var titleHit: UILabel!
    
    @IBOutlet weak var launchScreenPlaceholderLocation: NSLayoutConstraint!
    @IBOutlet weak var loadingAnimationLocation: NSLayoutConstraint!
    
    private var loader: Timer!
    private var loaderCounter: Int = 0
}

// MARK: Entrance Methods
extension WelcomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switchToApp()
    }
}

// MARK: Methods
extension WelcomeVC {
    func switchToApp() {
        launchScreenPlaceholderLocation.constant = view.bounds.size.width
        loadingAnimationLocation.constant = -view.bounds.size.width
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.loader = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.incrementLoader(_:)), userInfo: nil, repeats: true)
        }
    }
    
    @objc func incrementLoader(_ sender: Any!) {
        if loaderCounter == 3 {
            loader.invalidate()
            UIView.animate(withDuration: 0.3, animations: {
                self.replacer.alpha = 0
            }) { _ in
                self.animateBackground(direction: .left)
            }
        } else {
            loadingAnimator.text! += " ."
            loaderCounter += 1
        }
    }
    
    func animateBackground(direction: AnimationDirection) {
        if presentingViewController == nil {
            view.constraints.forEach { (constraint) in
                if constraint.identifier == "xValue" {
                    switch direction {
                    case .left:
                        constraint.constant = view.frame.width - welcomeBackground.frame.width
                    case .right:
                        constraint.constant = 0
                    }
                }
            }
        }
        
        autoreleasepool {
            UIView.animate(withDuration: 15, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                switch direction {
                case .left:
                    self.animateBackground(direction: .right)
                case .right:
                    self.animateBackground(direction: .left)
                }
            }
        }
    }
}

// MARK: Animation Direction
enum AnimationDirection {
    case left, right
}

//
//  WelcomeViewController.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/26/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: IBOutlets & IBActions
class WelcomeVC: UIViewController {

    @IBOutlet weak var welcomeBackground: UIImageView!
    @IBOutlet weak var backgroundOverlay: UIVisualEffectView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var welcomeDiv: UIView!
    @IBOutlet weak var welcomeDescription: UILabel!
    @IBOutlet weak var beginBtn: UIButton!
}

// MARK: Entrance Methods
extension WelcomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginBtn.space(with: 8)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        beginBtn.indicate(with: [6, 10], for: 0)
        
        backgroundOverlay.contentView.constraints.forEach { (constraint) in
            if constraint.identifier == "titleLbl.y" {
                constraint.constant = -(self.view.frame.height / 2.75)
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            self.titleLbl.font = self.titleLbl.font.withSize(20)
            self.view.layoutIfNeeded()
        }) { _ in
            self.animateBackground(direction: .left)
            UIView.animate(withDuration: 0.3) {
                self.welcomeLbl.alpha = 0.75
                self.welcomeDiv.alpha = 0.8
                self.welcomeDescription.alpha = 0.95
                self.beginBtn.alpha = 1
            }
        }
    }
}

// MARK: Methods
extension WelcomeVC {
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

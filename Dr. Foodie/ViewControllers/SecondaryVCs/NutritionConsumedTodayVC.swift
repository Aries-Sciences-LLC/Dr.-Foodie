//
//  NutritionConsumedTodayVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 11/29/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: IBOutlets & IBActions
class NutritionConsumedTodayVC: UIViewController {
    
    @IBOutlet weak var dataContainer: NutritionFacts!
    @IBOutlet weak var moveLeft: UIButton!
    @IBOutlet weak var moveRight: UIButton!
    
    @IBAction func swipedLeft(_ sender: Any) {
        _ = dataContainer.update(with: .left)
    }
    @IBAction func swipedRight(_ sender: Any) {
        _ = dataContainer.update(with: .right)
    }
    @IBAction func movedLeft(_ sender: Any) {
        pop()
        swipedLeft(sender)
    }
    @IBAction func movedRight(_ sender: Any) {
        pop()
        swipedRight(sender)
    }
}

// MARK: Methods
extension NutritionConsumedTodayVC {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        dataContainer.set(suggestions: UserNutrition.information(for: .today))
    }
}

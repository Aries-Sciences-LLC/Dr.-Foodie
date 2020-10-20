//
//  SnapMealHelpVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/16/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Entrance Methods & IBActions
class SnapMealHelpVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pop()
    }
    
    @IBAction func finished(_ sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func alternativeFinished(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//
//  DailyInformationVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/22/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: IBOutlets & IBActions
class DailyInformationVC: UIViewController {

    @IBOutlet weak var sectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var overallView: UIView!
    @IBOutlet weak var todayX: NSLayoutConstraint!
    @IBOutlet weak var overallX: NSLayoutConstraint!
    
    @IBAction func switchSection(_ sender: Any) {
        switch sectionSegmentControl.selectedSegmentIndex {
        case 0:
            todayX.constant = 0
            overallX.constant = view.bounds.width
        case 1:
            todayX.constant = -view.bounds.width
            overallX.constant = 0
        default:
            break
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: Methods
extension DailyInformationVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        overallX.constant = view.bounds.width
        
        addChild(storyboard!.instantiateViewController(withIdentifier: "todayNutritionData") as! NutritionConsumedTodayVC)
        addChild(storyboard!.instantiateViewController(withIdentifier: "overallNutritionData") as! TotalNutritionConsumedVC)
        
        sectionSegmentControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Futura-Bold", size: 13) ?? UIFont.boldSystemFont(ofSize: 13)], for: .normal)
    }
    
    override func addChild(_ childController: UIViewController) {
        super.addChild(childController)
        
        if childController.isKind(of: NutritionConsumedTodayVC.self) {
            todayView.addSubview(childController.view)
        }
        
        if childController.isKind(of: TotalNutritionConsumedVC.self) {
            overallView.addSubview(childController.view)
        }
        
        childController.didMove(toParent: self)
        
        childController.view.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("")
    }
}

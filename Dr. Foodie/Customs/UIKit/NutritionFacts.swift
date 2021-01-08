//
//  NutritionFacts.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 11/29/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import SnapKit

// MARK: NutritionFact

// MARK: Methods
class NutritionFact: UIView {
    func set(_ suggestion: UserNutrition.Suggestion) {
        let factLbl = UILabel()
        let suggestionLbl = UILabel()
        
        let factText = suggestion.fact.description
        let suggestionText = suggestion.description
        
        let firstCheckpoint = factText.firstIndex(of: ":")!.utf16Offset(in: factText) + 1
        let lastCheckpoint = factText.lastIndex(of: " ")!.utf16Offset(in: factText)
        
        let attributedFactText = NSMutableAttributedString(string: factText)
        attributedFactText.addAttribute(.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: lastCheckpoint))
        attributedFactText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: firstCheckpoint, length: factText.count - firstCheckpoint))
        attributedFactText.addAttribute(.font, value: UIFont(name: "Futura-Medium", size: 50) ?? UIFont.systemFont(ofSize: 50), range: NSRange(location: 0, length: firstCheckpoint))
        attributedFactText.addAttribute(.font, value: UIFont(name: "Futura-Bold", size: 75) ?? UIFont.boldSystemFont(ofSize: 75), range: NSRange(location: firstCheckpoint, length: lastCheckpoint - firstCheckpoint))
        attributedFactText.addAttribute(.font, value: UIFont(name: "Futura-Medium", size: 25) ?? UIFont.systemFont(ofSize: 25), range: NSRange(location: lastCheckpoint, length: factText.count - lastCheckpoint))
        
        factLbl.attributedText = attributedFactText
        factLbl.numberOfLines = 0
        
        suggestionLbl.text = suggestionText
        suggestionLbl.numberOfLines = 0
        suggestionLbl.textColor = .gray
        suggestionLbl.font = UIFont(name: "Futura-Medium", size: 12)
        
        addSubview(factLbl)
        addSubview(suggestionLbl)
        
        factLbl.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(200)
        }
        
        suggestionLbl.snp.makeConstraints { (make) in
            make.top.equalTo(center.y + 100)
            make.width.equalToSuperview().offset(-40)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: NutritionFacts

// MARK: Properties
class NutritionFacts: UIView {
    private var cellInView = 0
}

// MARK: Methods
extension NutritionFacts {
    func set(suggestions: [UserNutrition.Suggestion]) {
        for i in 0..<suggestions.count {
            let cell = NutritionFact()
            cell.set(suggestions[i])
            cell.alpha = i == 0 ? 1 : 0
            self.addSubview(cell)
            cell.snp.makeConstraints { (make) in
                make.top.width.height.equalToSuperview()
                make.leading.equalToSuperview().offset(bounds.width * CGFloat(i))
            }
        }
    }
    
    func update(with style: Swipe) -> Bool {
        switch style {
        case .left:
            if cellInView == subviews.count - 1 {
                return false
            }
            cellInView += 1
        case .right:
            if cellInView == 0 {
                return false
            }
            cellInView -= 1
        }
        
        for i in 0..<subviews.count {
            let location = CGFloat(i - cellInView)
            subviews[i].snp.updateConstraints { (make) in
                make.leading.equalToSuperview().offset(bounds.width * location)
            }
            
            UIView.animate(withDuration: 0.3) {
                self.subviews[i].alpha = location == 0 ? 1 : 0
            }
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        return true
    }
}

// MARK: Swipe Style
extension NutritionFacts {
    enum Swipe {
        case left, right
    }
}

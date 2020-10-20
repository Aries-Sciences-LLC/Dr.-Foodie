//
//  OnboardingBoard.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Properties
class OnboardingBoard: UIStackView {
    
    var boardPosition = 0
}

// MARK: Methods
extension OnboardingBoard {
    open func create(with data: OnboardingItemInfo, at position: Int) {
        boardPosition = position
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .center
        self.axis = .vertical
        self.distribution = .equalCentering
        self.spacing = 8
        
        let pageImage = UIImageView(image: data.pageImage)
        pageImage.contentMode = .scaleAspectFit
        addArrangedSubview(pageImage)
        pageImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }
        
        let title = UILabel()
        title.text = "\n\(data.titleText)"
        title.textColor = data.titleColor
        title.font = data.titleFont
        title.numberOfLines = 0
        title.textAlignment = .center
        addArrangedSubview(title)
        title.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-80)
        }
        
        let description = UILabel()
        description.text = "\n\(data.descriptionText)"
        description.textColor = data.descriptionColor
        description.font = data.descriptionFont
        description.numberOfLines = 0
        description.textAlignment = .center
        addArrangedSubview(description)
        description.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-80)
        }
        
        _ = move(towards: .neutral)
    }
    
    func move(towards direction: Direction) -> Bool {
        switch direction {
        case .right:
            boardPosition += 1
        case .left:
            boardPosition -= 1
        case .neutral:
            break
        }
        
        snp.remakeConstraints { (make) in
            if boardPosition == 0 {
                make.leading.equalToSuperview()
            } else if boardPosition < 0 {
                make.leading.equalToSuperview().offset(-superview!.frame.width)
            } else if boardPosition > 0 {
                make.leading.equalToSuperview().offset(superview!.frame.width)
            }
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.height.equalToSuperview().dividedBy(2)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .allowAnimatedContent, animations: {
            self.transform = self.boardPosition == 0 ? .identity : CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: nil)
        
        return boardPosition == -2
    }
}

// MARK: Direction Handler
enum Direction {
    case right, left, neutral
}

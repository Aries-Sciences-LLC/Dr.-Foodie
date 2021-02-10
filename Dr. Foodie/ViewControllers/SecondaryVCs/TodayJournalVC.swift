//
//  TodayJournalViewController.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 1/13/21.
//  Copyright © 2021 Aries Sciences LLC. All rights reserved.
//

import UIKit
import CardSlider

// MARK: Meal
class Meal: CardSliderItem {
    let image: UIImage
    let title: String
    let subtitle: String?
    let description: String?
    
    let nutrition: NutritionOutput
    
    init(image: UIImage,
         title: String,
         subtitle: String?,
         description: String?,
         nutrition: NutritionOutput) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.nutrition = nutrition
    }
}

// MARK: Properties & IBActions
class TodayJournalVC: CardSliderViewController {
    
    var meals: [Meal] = []
    var currentItem = 0
    
    @IBAction func pageSelected(_ sender: Any) {
        (parent as? HomeVC)?.onUserClicked(selected: meals[currentItem].nutrition)
    }
}

// MARK: Methods
extension TodayJournalVC {
    func updateDataSource() {
        dataSource = self
        collectionView.reloadData()
        viewWillAppear(true)
        
        let cellSize = CGSize(width: CGFloat(meals.count) * self.view.frame.width, height: self.view.frame.height)
        let contentOffset = collectionView.contentOffset
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        
        collectionView.layoutIfNeeded()
    }
    
    public func reload() {
        meals = []
        JournalManager.meals.forEach { (meal) in
            self.meals.append(convert(meal: meal))
        }
        meals.reverse()
        if dataSource != nil {
            collectionView.reloadData()
        }
    }
    
    private func convert(meal: JournalManager.Food) -> Meal {
        let meal = Meal(
            image: meal.image,
            title: meal.names.joined(separator: ", "),
            subtitle: meal.time.convertTo12hour(),
            description: nil,
            nutrition: meal.nutritionInformation
        )
        return meal
    }
}

// MARK: CardSliderDataSourcexw
extension TodayJournalVC: CardSliderDataSource {
    func userSwiped(to item: Int) {
        currentItem = item
    }
    
    func item(for index: Int) -> CardSliderItem {
        return meals[index]
    }
    
    func numberOfItems() -> Int {
        return meals.count
    }
}

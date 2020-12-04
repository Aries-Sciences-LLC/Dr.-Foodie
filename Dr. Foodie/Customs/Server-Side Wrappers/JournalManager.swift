//
//  JournalManager.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/18/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Properties, Structures
class JournalManager {
    private(set) static var meals: [Food] = []
    private(set) static var history: [String: [Food]] = [:]
    
    private static var started: Bool = false
    private static var buffer: Int = 0
    private static var historyCounter: [String] = []
    
    struct Food {
        var names: [String]
        var image: UIImage
        var time: Date
        var nutritionInformation: NutritionOutput
        
        public init(names: [String], image: UIImage, time: Date = Date(), nutritionInformation: NutritionOutput) {
            self.names = names
            self.image = image
            self.time = time
            self.nutritionInformation = nutritionInformation
        }
        
        public init(names: [String], image: URL, time: Date, nutritionInformation: NutritionOutput) {
            self.init(names: names, image: UIImage(data: try! Data(contentsOf: image))!, time: time, nutritionInformation: nutritionInformation)
        }
    }
}

// MARK: Methods
extension JournalManager {
    public static func add(meal: Food) {
        if Calendar.current.isDateInToday(meal.time) {
            meals.append(meal)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let formatted = formatter.string(from: meal.time)
            if history[formatted] == nil {
                history[formatted] = [meal]
                historyCounter.insert(formatted, at: 0)
            } else {
                history[formatted]!.append(meal)
            }
        }
    }
    
    public static func getLatest() -> [Food] {
        if !started {
            buffer = historyCounter.count - 1
            started = true
        }
        
        let selected = history[historyCounter[buffer]]
        buffer -= 1
        return selected!
    }
}

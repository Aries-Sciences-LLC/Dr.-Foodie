//
//  JournalManager.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/18/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: DateOrganizer

// MARK: Properties
class DateOrganizer {
    private(set) var dates: [String] = []
    
    private var buffer: Int = 0
    private var location: Int {
        buffer += 1
        
        if buffer >= dates.count {
            buffer = 0
        }
        
        return dates.count - buffer - 1
    }
    
}

// MARK: Methods
extension DateOrganizer {
    public func getNextDate() -> String {
        return dates[location]
    }
    
    public func add(date: Date) -> (String, Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let formatted = formatter.string(from: date)
        
        for prevDate in dates {
            if Int(prevDate.prefix(5).suffix(2)) == Int(formatted.prefix(5).suffix(2)) &&
                Int(prevDate.suffix(4))          ==           Int(formatted.suffix(4)) &&
                Int(formatted.prefix(2))         ==             Int(prevDate.prefix(2)) {
                return (formatted, false)
            }
        }
        
        dates.append(formatted)
        dates = dates.compactMap(formatter.date(from:)).sorted(by: <).compactMap(formatter.string(from:))
        
        return (formatted, true)
    }
}

// MARK: JournalManager

// MARK: Properties & Structures
class JournalManager {
    private(set) static var meals: [Food] = []
    private(set) static var history: [String: [Food]] = [:]
    
    private static var historyCounter: DateOrganizer = DateOrganizer()
    
    static var count: Int {
        get {
            var buffer = 0
            for day in historyCounter.dates {
                buffer += history[day]!.count
            }
            
            return buffer + meals.count
        }
    }
    
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
            let (stamp, isNew) = historyCounter.add(date: meal.time)
            if isNew {
                history[stamp] = [meal]
            } else {
                history[stamp]!.append(meal)
            }
        }
    }
    
    public static func getLatest() -> [Food] {
        return history[historyCounter.getNextDate()]!
    }
}

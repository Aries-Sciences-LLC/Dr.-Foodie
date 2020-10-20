//
//  RestaurantCategories.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation

// MARK: Properties
class RestaurantCategories {
    private(set) static var categories: [String] = []
}

// MARK: Methods
extension RestaurantCategories {
    static func fetch(completion: @escaping () -> Void) {
        CloudKitManager.categories(action: .fetch) { (categories) in
            self.categories = categories
            completion()
        }
    }
    
    static func add(with name: String) {
        categories.append(name)
        CloudKitManager.categories(action: .upload) { _ in
            
        }
    }
    
    static func create(with bulk: [String]) {
        bulk.forEach { (name) in
            self.categories.append(name)
        }
        CloudKitManager.categories(action: .upload) { _ in
            
        }
    }
    
    static func remove(name: String) {
        categories.remove(at: categories.firstIndex(of: name)!)
        CloudKitManager.categories(action: .upload) { _ in
            
        }
    }
}

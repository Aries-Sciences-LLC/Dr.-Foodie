//
//  RangeReplaceableCollection.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/20/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection where Element: Equatable {
    @discardableResult
    mutating func appendIfNotContains(_ element: Element) -> (appended: Bool, memberAfterAppend: Element) {
        if let index = firstIndex(of: element) {
            return (false, self[index])
        } else {
            append(element)
            return (true, element)
        }
    }
}

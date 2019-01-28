//
//  Array.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 27/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

extension Array {
    /// Check bounds of array, return nil if index out of bounds
    subscript(safe index: Index) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    func containSameElements(_ array: [Element]) -> Bool {
        var selfCopy = self
        var secondArrayCopy = array
        while let currentItem = selfCopy.popLast() {
            if let indexOfCurrentItem = secondArrayCopy.index(of: currentItem) {
                secondArrayCopy.remove(at: indexOfCurrentItem)
            } else {
                return false
            }
        }
        return secondArrayCopy.isEmpty
    }
}

//
//  ApplyOperator.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

infix operator <-< : AssignmentPrecedence

@discardableResult
func <-< <T:AnyObject> (left: T, right: (T)->()) -> T {
    right(left)
    return left
}

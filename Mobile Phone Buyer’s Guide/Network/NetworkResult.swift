//
//  NetworkResult.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(data: T)
    case failure(error: Error)
}

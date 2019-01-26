//
//  Phone.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

struct Phone: Codable {
    let id: Int
    let name: String
    let price: Double
    let brand: String
    let description: String
    let rating: Double
    let thumbImageURL: String
}

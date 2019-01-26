//
//  NetworkRouter.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

enum Router {
    func request() throws -> URLRequest {
        return URLRequest(url: URL(string: "http://")!)
    }
}

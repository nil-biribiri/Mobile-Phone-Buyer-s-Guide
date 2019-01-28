//
//  NetworkRouter.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

enum Router {
    case getMobilesList
    case getMobileImages(mobileId: String)

    private static let baseURLString = "https://scb-test-mobile.herokuapp.com/api"

    private enum HTTPMethod {
        case get
        case post
        case put
        case delete

        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .delete: return "DELETE"
            }
        }
    }

    private var method: HTTPMethod {
        switch self {
        case .getMobilesList: return .get
        case .getMobileImages: return .get
        }
    }

    private var path: String {
        switch self {
        case .getMobilesList:
            return "/mobiles/"
        case .getMobileImages(let mobileId):
            return "/mobiles/\(mobileId)/images"
        }
    }

    func request() throws -> URLRequest {
        let urlString = "\(Router.baseURLString)\(path)"

        guard let url = URL(string: urlString) else {
            throw ServiceError.urlNotCorrect(url: urlString)
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        dump("Request: \(request)")
        switch self {
        case .getMobilesList:
            return request
        case .getMobileImages:
            return request
        }
    }

}

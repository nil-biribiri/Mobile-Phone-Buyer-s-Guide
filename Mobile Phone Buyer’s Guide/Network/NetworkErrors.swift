//
//  NetworkErrors.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

enum ServiceError: Error, LocalizedError {
    case receiveErrorFromService(statusCode: Int, message: String)
    case parseJSONError(resultType: String, message: String, responseData: String)
    case unknownError
    case urlNotCorrect(url: String)

    var errorDescription: String? {
        switch self {
        case .receiveErrorFromService(let statusCode, let message):
            return "Error \(message) with status code \(statusCode)."
        case .parseJSONError(let resultType, let message, let responseData):
            return "ParseJSON \(responseData) to\(resultType) error \(message)."
        case .unknownError:
            return "Unknown error."
        case .urlNotCorrect(let url):
            return "URL \(url) not correct."
        }
    }
}

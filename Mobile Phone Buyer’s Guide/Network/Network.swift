//
//  Network.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation

final class Network {
    static let shared = Network()

    private let config: URLSessionConfiguration
    private let session: URLSession

    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }

    func request<T: Decodable>(router: Router, completion: @escaping (Result<T>) -> ()) {
        do {
            let task = try session.dataTask(with: router.request()) { (data, urlResponse, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        return completion(Result<T>.failure(error: error))
                    }

                    guard let statusCode = urlResponse?.getStatusCode(), (200...299).contains(statusCode) else {
                        let statusCode = urlResponse?.getStatusCode()
                        let errorType: ServiceError

                        switch statusCode {
                        case -1009:
                            errorType = .noConnectionError
                        case .some(let code):
                            // Get error message from payload here
                            errorType = .receiveErrorFromService(statusCode: code, message: "")
                        case .none:
                            errorType = .unknownError
                        }
                        return completion(Result<T>.failure(error: errorType))
                    }

                    guard let data = data else {
                        return completion(Result<T>.failure(error: ServiceError.unknownError))
                    }

                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        return completion(Result.success(data: result))
                    } catch let decodingError {
                        return completion(Result.failure(error: ServiceError.parseJSONError(resultType: String(describing: T.self),
                                                                                            message: decodingError.localizedDescription,
                                                                                            responseData: data.getJSONString())))
                    }
                }
            }
            task.resume()

        } catch let error {
            completion(Result<T>.failure(error: error))
        }
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

extension Data {
    func getJSONString() -> String {
        if let serializedObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let serializedJson = serializedObject as? [String: AnyObject] {
            return serializedJson.prettyPrint()
        }
        return ""
    }
}

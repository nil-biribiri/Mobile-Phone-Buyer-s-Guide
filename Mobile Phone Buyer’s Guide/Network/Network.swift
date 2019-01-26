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
                        return completion(Result<T>.failure(error))
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
                        return completion(Result<T>.failure(errorType))
                    }

                    guard let data = data else {
                        return completion(Result<T>.failure(ServiceError.unknownError))
                    }

                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        return completion(Result.success(result))
                    } catch let decodingError {
                        return completion(Result.failure(ServiceError.parseJSONError(resultType: String(describing: T.self),
                                                                                            message: decodingError.localizedDescription,
                                                                                            responseData: data.getJSONString())))
                    }
                }
            }
            task.resume()

        } catch let error {
            completion(Result<T>.failure(error))
        }
    }
}

fileprivate extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

fileprivate extension Data {
    // Get pretty print JSON string
    func getJSONString() -> String {
        if let serializedObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let serializedJson = serializedObject as? [String: AnyObject] {
            return serializedJson.prettyPrint()
        }
        return String(data: self, encoding: String.Encoding.utf8) ?? ""
    }
}

fileprivate extension Dictionary where Key == String, Value == AnyObject {
    func prettyPrint() -> String {
        var string: String = ""
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted){
            if let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
                string = nstr as String
            }
        }
        return string
    }
}

//
//  ListWorker.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright (c) 2562 NilNilNil. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Realm
import RealmSwift

class ListWorker {
    let phoneStore = PhoneStore()
    var notificationToken: NotificationToken? = nil

    func fetchPhoneList(withPredicate predicate: PhoneStore.Predicate = .priceAscending,
                        completion: @escaping (Result<[Phone]>) -> Void) {
        Network.shared.request(router: Router.getMobilesList) { [weak self] (result: Result<[Phone]>) in
            switch result {
            case .success(let value):
                self?.phoneStore.savePhoneList(value)
                if let storedData = self?.phoneStore.getPhoneList(predicate) {
                    return completion(Result.success(storedData))
                } else {
                    return completion(Result.success(value))
                }
            case .failure(let error):
                if let phoneData = self?.phoneStore.getPhoneList(predicate) {
                    return completion(Result.success(phoneData))
                }
                return completion(Result.failure(error))
            }
        }
    }

    func setFavorite(withId id: Int) -> [Phone]? {
        phoneStore.setFavorite(withId: id)
        return phoneStore.getPhoneList()
    }
}

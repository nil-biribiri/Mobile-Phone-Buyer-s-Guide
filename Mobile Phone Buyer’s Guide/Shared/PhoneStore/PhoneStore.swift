//
//  PhoneStore.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 27/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class PhoneStore {
    static let shared = PhoneStore()

    @objc enum Predicate: Int {
        case priceAscending
        case priceDescending
        case ratingDescending

        fileprivate var phoneData: Results<Phone>? {
            switch self {
            case .priceAscending:
                return DataManager.shared.objects(Phone.self)?.sorted(byKeyPath: "price", ascending: true)
            case .priceDescending:
                return DataManager.shared.objects(Phone.self)?.sorted(byKeyPath: "price", ascending: false)
            case .ratingDescending:
                return DataManager.shared.objects(Phone.self)?.sorted(byKeyPath: "rating", ascending: false)
            }
        }
    }

    func savePhoneList(_ phoneList: [Phone]) {
        DataManager.shared.configureRealm()
        DataManager.shared.add(phoneList)
    }

    func getPhoneList(_ predicate: Predicate = .priceAscending) -> [Phone]? {
        if let phoneData = predicate.phoneData {
            return Array(phoneData)
        } else {
            return nil
        }
    }

    func getFavoritePhoneList(_ predicate: Predicate = .priceAscending) -> [Phone]? {
        if let phoneData = getPhoneList(predicate) {
            return phoneData.filter{ $0.isFavorite == true }
        } else {
            return nil
        }
    }

    func setFavorite(withId id: Int) {
        DataManager.shared.runTransaction {
            if let updateObject = DataManager.shared.object(Phone.self, key: id) {
                updateObject.isFavorite.toggle()
            }
        }
    }

    func setSortPredicate(_ predicate: PhoneStore.Predicate) {
        let sortData = SortPredicate()
        sortData.predicate = predicate
        DataManager.shared.configureRealm()
        DataManager.shared.add(sortData)
    }

    func getSortPredicate() -> SortPredicate? {
        return DataManager.shared.objects(SortPredicate.self)?.first
    }
}

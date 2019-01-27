//
//  Phone.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 26/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class SortPredicate: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var predicate: PhoneStore.Predicate = .priceAscending

    override static func primaryKey() -> String? {
        return "id"
    }
}

class Phone: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var price: Double = 0
    @objc dynamic var brand: String = ""
    @objc dynamic var _description: String = ""
    @objc dynamic var rating: Double = 0
    @objc dynamic var thumbImageURL: String = ""
    @objc dynamic var isFavorite: Bool = false

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case brand
        case rating
        case thumbImageURL
        case isFavorite
        case _description = "description"
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.brand = try container.decode(String.self, forKey: .brand)
        self._description = try container.decode(String.self, forKey: ._description)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.thumbImageURL = try container.decode(String.self, forKey: .thumbImageURL)
        // To prevent favorite variable getting override
        self.isFavorite = DataManager.shared.object(Phone.self, key: id)?.isFavorite ?? false
        super.init()
    }

    required init() {
        super.init()
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}


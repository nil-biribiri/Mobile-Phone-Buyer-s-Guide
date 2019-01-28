//
//  PhoneStoreTest.swift
//  Mobile Phone Buyer’s GuideTests
//
//  Created by Tanasak Ngerniam on 28/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

@testable import Mobile_Phone_Buyer_s_Guide
import XCTest

class PhoneStoreTest: XCTestCase {
    var favoritedPhoneData: [Phone]!
    var notFavoritedPhoneData: [Phone]!
    var sortData: SortPredicate!
    var sut: PhoneStore!

    override func setUp() {
        super.setUp()
        sut = PhoneStore()
        setData()
    }

    override func tearDown() {
        DataManager.shared.clearAllData()
        sut = nil
        favoritedPhoneData = nil
        notFavoritedPhoneData = nil
        sortData = nil
        super.tearDown()
    }

    func setData() {
        favoritedPhoneData = [Phone(id: 0,
                           name: "MockName",
                           price: 100.222,
                           brand: "MockBrand",
                           desciption: "MockDescription",
                           rating: 4.5,
                           thumbImageURL: "link",
                           isFavorite: true)]
        notFavoritedPhoneData = [Phone(id: 1,
                                    name: "MockName_2",
                                    price: 99,
                                    brand: "MockBrand_2",
                                    desciption: "MockDescription_2",
                                    rating: 4.9,
                                    thumbImageURL: "link_2",
                                    isFavorite: false)]
        sortData = SortPredicate(predicate: .ratingDescending)
    }

    func testSavePhoneList() {
        // Given
        sut.savePhoneList(favoritedPhoneData)

        // When
        let phoneList = sut.getPhoneList()

        // Then
        XCTAssertEqual(phoneList, favoritedPhoneData)
    }

    func testGetEmptyPhoneList() {
        // Given

        // When
        let phoneList = sut.getPhoneList()

        // Then
        XCTAssertEqual(phoneList, [])
    }


    func testGetPhoneList() {
        // Given
        sut.savePhoneList(favoritedPhoneData)
        sut.savePhoneList(notFavoritedPhoneData)

        // When
        let phoneList = sut.getPhoneList()

        // Then
        let combinePhoneData = favoritedPhoneData + notFavoritedPhoneData
        XCTAssertEqual(phoneList?.containSameElements(combinePhoneData), true)
    }

    func testGetFavoritePhoneList() {
        // Given
        sut.savePhoneList(favoritedPhoneData)
        sut.savePhoneList(notFavoritedPhoneData)

        // When
        let favoritePhoneList = sut.getFavoritePhoneList()

        // Then
        XCTAssertEqual(favoritePhoneList, favoritedPhoneData)
    }

    func testSetFavorite() {
        // Given
        sut.savePhoneList(notFavoritedPhoneData)

        // When
        sut.setFavorite(withId: (notFavoritedPhoneData.first?.id)!)
        let favoritePhone = sut.getFavoritePhoneList()

        // Then
        XCTAssertNotEqual(favoritePhone, [])
    }

    func testSetSortPredicate() {
        // Given
        sut.setSortPredicate(sortData.predicate)

        // When
        let sortPredicate = sut.getSortPredicate()

        // Then
        XCTAssertEqual(sortPredicate?.predicate, sortData.predicate)
    }
}

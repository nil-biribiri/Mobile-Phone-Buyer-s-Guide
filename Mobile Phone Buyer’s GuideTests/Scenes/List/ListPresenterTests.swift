//
//  ListPresenterTests.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 28/1/2562 BE.
//  Copyright (c) 2562 NilNilNil. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Mobile_Phone_Buyer_s_Guide
import XCTest

class ListPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListPresenter!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupListPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupListPresenter() {
        sut = ListPresenter()
    }

    // MARK: Test doubles
    class ListDisplayLogicSpy: ListDisplayLogic {
        // MARK: Method call expectations
        var displayDeviceListCalled = false
        var displayErrorListCalled = false
        var hideLoaderCalled = false

        // MARK: Argument expectations
        var viewModel = List.DeviceList.ViewModel(displayPhone: [])

        func displayDeviceList(viewModel: List.DeviceList.ViewModel) {
            self.viewModel = viewModel
            displayDeviceListCalled = true
        }

        func displayError(error: List.DeviceList.Error) {
            displayErrorListCalled = true
        }

        func displayLoader() {}

        func hideLoader() {
            hideLoaderCalled = true
        }
    }

    // MARK: Tests
    func testPresentPhoneListSuccess() {
        // Given
        let spy = ListDisplayLogicSpy()
        sut.viewController = spy
        let response = List.DeviceList.Response(phoneList: [], errorMessage: nil)

        // When
        sut.presentPhoneList(response: response)

        // Then
        XCTAssertTrue(spy.displayDeviceListCalled, "presentPhoneList(response:) should ask the view controller to display the result.")
        XCTAssertTrue(spy.hideLoaderCalled)
    }

    func testPresentPhoneListError() {
        // Given
        let spy = ListDisplayLogicSpy()
        sut.viewController = spy
        let response = List.DeviceList.Response(phoneList: nil, errorMessage: "Error message")

        // When
        sut.presentPhoneList(response: response)

        // Then
        XCTAssertTrue(spy.displayErrorListCalled, "presentPhoneList(response:) should ask the view controller to display error.")
    }

    func testDisplayDeviceListFormatData() {
        // Given
        let spy = ListDisplayLogicSpy()
        sut.viewController = spy
        let phone = Phone(id: 0,
                          name: "MockName",
                          price: 100.222,
                          brand: "MockBrand",
                          desciption: "MockDescription",
                          rating: 4.5,
                          thumbImageURL: "link",
                          isFavorite: true)
        let mockPhoneList = [phone]
        let response = List.DeviceList.Response(phoneList: mockPhoneList, errorMessage: nil)
        let expectedViewModel = [List.DeviceList.ViewModel.DisplayPhone.init(id: 0,
                                                                             name: "MockName",
                                                                             description: "MockDescription",
                                                                             price: "Price: $100.22",
                                                                             rating: "Rating: 4.5",
                                                                             thumbnailPath: "link",
                                                                             isFavorite: true)]

        // When
        sut.presentPhoneList(response: response)

        // Then
        XCTAssertEqual(spy.viewModel.displayPhone, expectedViewModel)
    }

}

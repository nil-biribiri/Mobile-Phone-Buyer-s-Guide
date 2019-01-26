//
//  BasePresenter.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 25/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

protocol BasePresenterLogic {
    func showLoading()
    func hideLoading()
}

class BasePresenter {
    weak var baseViewController: BaseDisplayLogic?

    func showLoading() {
        baseViewController?.displayLoader()
    }

    func hideLoading() {
        baseViewController?.hideLoader()
    }
}

//
//  BaseViewController.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 25/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

protocol BaseDisplayLogic: class {
    func displayLoader()
    func hideLoader()
}

class BaseViewController: UIViewController, BaseDisplayLogic {
    private lazy var loadingView: UIViewController = {
        let loadingView = self.loading
        return loadingView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
    }

    func displayLoader() {
        add(loadingView)
    }

    func hideLoader() {
        loadingView.remove()
    }
}

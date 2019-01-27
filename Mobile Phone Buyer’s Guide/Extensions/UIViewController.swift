//
//  UIViewController.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 25/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

extension UIViewController {
    var loading: UIViewController {
        let viewController = UIViewController()

        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        viewController.view.addSubview(indicator, attachedTo: viewController.view)

        return viewController
    }

    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func showInfoAlert(title: String? = "", message: String? = "", buttonTitle: String? = "OK", handler: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if (buttonTitle != nil) {alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: {
            handler
        }()))
        }
        present(alert, animated: true, completion: nil)
    }

}

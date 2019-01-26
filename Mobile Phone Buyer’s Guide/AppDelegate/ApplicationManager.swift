//
//  ApplicationManager.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 25/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

protocol ApplicationManagerProtocol: class {
    func initAllSDKs()
    func initGlobalAppearance()
    func setRootVC(_ rootVC: UIViewController, inWindow window: UIWindow?)
}

class ApplicationManager: ApplicationManagerProtocol {
    static let sharedInstance = ApplicationManager()

    private init() {
        initAllSDKs()
        initGlobalAppearance()
    }

    func initAllSDKs() {

    }

    func initGlobalAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    func setRootVC(_ rootVC: UIViewController, inWindow window: UIWindow?) {
        window?.rootViewController = UINavigationController.init(rootViewController: rootVC)
    }

}

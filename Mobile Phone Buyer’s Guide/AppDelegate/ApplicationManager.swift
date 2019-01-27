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
    func setRootVC(_ rootVC: UIViewController, inWindow window: inout UIWindow?)
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
        UINavigationBar.appearance().isTranslucent = false
    }

    func setRootVC(_ rootVC: UIViewController, inWindow window: inout UIWindow?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: rootVC)
//        window?.rootViewController = rootVC

        window?.makeKeyAndVisible()
    }

}

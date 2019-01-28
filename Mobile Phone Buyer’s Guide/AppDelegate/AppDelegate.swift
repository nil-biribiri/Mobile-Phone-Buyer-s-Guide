//
//  AppDelegate.swift
//  Mobile Phone Buyer’s Guide
//
//  Created by Tanasak Ngerniam on 25/1/2562 BE.
//  Copyright © 2562 NilNilNil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Return early for Unit tests
        if let _ = NSClassFromString("XCTest") {
            return true
        }

        ApplicationManager.sharedInstance.setRootVC(MainSegmentViewController(), inWindow: &window)
        return true
    }
}


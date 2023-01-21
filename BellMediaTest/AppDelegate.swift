//
//  AppDelegate.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/21/23.
//

import UIKit

class CommonNavigationContoller : UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var windows: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        windows = UIWindow()
        windows?.makeKeyAndVisible()

        windows?.rootViewController = CommonNavigationContoller(rootViewController: ViewController())
        return true
    }
}

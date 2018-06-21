//
//  AppDelegate.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 20.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let interfaceController = InterfaceController.shared
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = interfaceController.window
        interfaceController.openInitialScreen()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let sourceApp = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String else {
            return true
        }
        VKSdk.processOpen(url, fromApplication: sourceApp)
        return true
    }
}


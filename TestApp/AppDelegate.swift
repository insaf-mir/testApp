//
//  AppDelegate.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 20.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let interfaceController = InterfaceController.shared
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = interfaceController.window
        interfaceController.openInitialScreen()
        return true
    }
}


//
//  InterfaceController.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 20.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

class InterfaceController: NSObject {
    let window: UIWindow
    static let shared = InterfaceController()
    
    override init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        super.init()
    }
    
    func openInitialScreen() {
        window.rootViewController = UINavigationController(rootViewController: LoginController())
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }    
}

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
    private var navigationController: UINavigationController?
    override init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        super.init()
    }
    
    func openFriendsList() {
        let controller = FriendsListController()
        navigationController?.setViewControllers([controller], animated: true)
    }
    
    func openInitialScreen() {
        navigationController = UINavigationController(rootViewController: LoginController())
        window.rootViewController = navigationController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }    
}

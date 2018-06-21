//
//  LoginController.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 21.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginController: UIViewController {
    
    lazy var contentView = LoginView(frame: UIScreen.main.bounds)
    
    lazy var vkSdk: VKSdk = {
        if VKSdk.initialized() {
            return VKSdk.instance()
        }
        return VKSdk.initialize(withAppId: VKAppID)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
        contentView.loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
}

extension LoginController {
    
    @objc
    private func loginAction() {
        let permissions = [VK_PER_FRIENDS]
        VKSdk.authorize(permissions)
    }
}

extension LoginController: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(captchaError)
    }
}

extension LoginController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(result.state)
        if result.token != nil {
            let controller = FriendsListController()
            navigationController?.pushViewController(controller, animated: true)
            return
        }
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ошибка", message: "Не удалось авторизоваться в контакте", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("auth failed")
    }
    
    
}

//
//  LoginView.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 21.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Авторизоваться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(loginButton)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
    }
}

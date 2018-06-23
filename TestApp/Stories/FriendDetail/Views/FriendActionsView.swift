//
//  FriendActionButtonsView.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 23.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

extension FriendActionView {
    struct Appearance {
        let buttonHeight: CGFloat = 30
    }
}

class FriendActionView: UIView {
    let appearance = Appearance()
    lazy var messageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .defaultBlue
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.layer.cornerRadius = appearance.buttonHeight / 2
        button.clipsToBounds = true
        return button
    }()
    
    lazy var friendsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .colorFromHex(0xE6EBEF)
        button.setTitle("Friends", for: .normal)
        button.setTitleColor(.defaultBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.layer.cornerRadius = appearance.buttonHeight / 2
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(messageButton)
        addSubview(friendsButton)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        messageButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(friendsButton)
        }
        friendsButton.snp.makeConstraints { make in
            make.leading.equalTo(messageButton.snp.trailing).offset(10)
            make.height.equalTo(appearance.buttonHeight)
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
}

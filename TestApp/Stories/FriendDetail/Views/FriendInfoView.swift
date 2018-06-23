//
//  FriendInfoView.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 23.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import SDWebImage

extension FriendInfoView {
    struct Appearance {
        let avatarSize: CGFloat = 60
    }
}

class FriendInfoView: UIView {
    let appearance = Appearance()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = appearance.avatarSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    lazy var connectionStateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var labelsContainer = UIView()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "info").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .defaultBlue
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(avatarImageView)
        addSubview(labelsContainer)
        labelsContainer.addSubview(titleLabel)
        labelsContainer.addSubview(connectionStateLabel)
        labelsContainer.addSubview(cityLabel)
        addSubview(infoButton)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.height.width.equalTo(appearance.avatarSize)
        }
        labelsContainer.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            make.top.bottom.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        connectionStateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        cityLabel.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.greaterThanOrEqualTo(connectionStateLabel.snp.bottom)
        }
        infoButton.snp.makeConstraints { make in
            make.leading.equalTo(labelsContainer.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func configure(_ viewModel: FriendViewModel) {
        titleLabel.text = viewModel.name
        connectionStateLabel.text = viewModel.lastSeen
        cityLabel.text = viewModel.city
        guard let url = URL(string: viewModel.imageUrl) else {
            return
        }
        avatarImageView.sd_setImage(with: url, completed: nil)
    }
}

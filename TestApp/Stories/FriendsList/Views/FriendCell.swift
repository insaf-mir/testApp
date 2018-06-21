//
//  FriendCell.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 21.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import SDWebImage

extension FriendCell {
    struct Appearance {
        let avatarSize: CGFloat = 40
    }
}

class FriendCell: UITableViewCell {
    let appearance = Appearance()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = appearance.avatarSize / 2
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorFromHex(0xE4E4E4)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.addSubview(avatarImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(15)
            make.height.width.equalTo(appearance.avatarSize)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            make.trailing.top.bottom.equalToSuperview().inset(15)
        }
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1 / UIScreen.main.scale)
        }
    }
    
    func configure(_ viewModel: FriendViewModel) {
        titleLabel.text = viewModel.name
        guard let url = URL(string: viewModel.imageUrl) else {
            return
        }
        avatarImageView.sd_setImage(with: url, completed: nil)
    }
    
}

//
//  FriendDetailView.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 22.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

class FriendDetailView: UIView {
    
    lazy var contentView = UIView()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    lazy var friendInfoView = FriendInfoView()
    lazy var friendActionsView = FriendActionView()
    lazy var segmentedContainer = UIView()
    lazy var segmentedView = SegmentedView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        segmentedContainer.addSubview(segmentedView)
        stackView.addArrangedSubview(friendInfoView)
        stackView.addArrangedSubview(friendActionsView)
        stackView.addArrangedSubview(segmentedContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints(in controller: UIViewController) {
        contentView.snp.makeConstraints { make in
            make.top.equalTo(controller.topLayoutGuide.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        segmentedView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }

}

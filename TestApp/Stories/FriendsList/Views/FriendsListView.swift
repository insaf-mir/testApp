//
//  FriendsListView.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 21.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

class FriendsListView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.dlReuseIdentifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(tableView)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints(in controller: UIViewController) {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(controller.topLayoutGuide.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

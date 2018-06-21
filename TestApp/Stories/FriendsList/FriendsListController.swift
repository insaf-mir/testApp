//
//  FriendsListController.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 21.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class FriendsListController: UIViewController {
    lazy var disposeBag = DisposeBag()
    lazy var viewModel = FriendsListViewModel()
    lazy var contentView = FriendsListView(frame: UIScreen.main.bounds)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        contentView.makeConstraints(in: self)
        bindData()
        viewModel.fetchData()
    }
    
    private func bindData() {
        viewModel.friends
            .bind(to: contentView.tableView.rx.items(cellIdentifier: FriendCell.dlReuseIdentifier)) { index, model, cell in
                guard let cell = cell as? FriendCell else {
                    return
                }
                cell.configure(model)
            }
            .disposed(by: disposeBag)
    }
}

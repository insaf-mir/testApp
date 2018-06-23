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
import SVPullToRefresh

class FriendsListController: UIViewController {
    lazy var disposeBag = DisposeBag()
    lazy var viewModel = FriendsListViewModel()
    lazy var contentView = FriendsListView(frame: UIScreen.main.bounds)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        contentView.makeConstraints(in: self)
        contentView.tableView.delegate = self
        bind()
        viewModel.fetchData()
        contentView.tableView.addPullToRefresh {
            self.viewModel.updateData()
        }
        contentView.tableView.addInfiniteScrolling {
            self.viewModel.fetchNextPage()
        }
    }
    
    private func bind() {
        viewModel.friends
            .bind(to: contentView.tableView.rx.items(cellIdentifier: FriendCell.dlReuseIdentifier)) { index, model, cell in
                guard let cell = cell as? FriendCell else {
                    return
                }
                cell.configure(model)
            }
            .disposed(by: disposeBag)
        
        viewModel.isEnableInfiniteScroll.asObservable()
            .subscribe(onNext: { enabled in
                self.contentView.tableView.showsInfiniteScrolling = enabled
            })
            .disposed(by: disposeBag)
        
        viewModel.isEndLoadNextPage.asObservable()
            .subscribe(onNext: { enabled in
                if self.contentView.tableView.infiniteScrollingView == nil {
                    return
                }
                self.contentView.tableView.infiniteScrollingView.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.isEndUpdate.asObservable()
            .subscribe(onNext: { enabled in
                if self.contentView.tableView.pullToRefreshView == nil {
                    return
                }
                self.contentView.tableView.pullToRefreshView.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}

extension FriendsListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendViewModel = viewModel.friends.value[indexPath.row]
        let controller = FriendDetailController(viewModel: friendViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}

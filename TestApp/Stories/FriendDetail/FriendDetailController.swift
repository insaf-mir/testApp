//
//  FriendDetailController.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 22.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

class FriendDetailController: UIViewController {
    lazy var contentView = FriendDetailView(frame: UIScreen.main.bounds)
    let viewModel: FriendViewModel
    
    init(viewModel: FriendViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.name
        contentView.makeConstraints(in: self)
        contentView.friendInfoView.configure(viewModel)
        contentView.segmentedView.configure(with: prepareSegmentedViewModels())
    }
    
    // test data
    private func prepareSegmentedViewModels() -> [SegmentViewModel] {
        let titles = ["1,2K","23","365","223","123","456","354"]
        let subtitles = ["friends","in common","followers","photos","videos","audios","presents"]
        let viewModels: [SegmentViewModel] = titles.enumerated().map {
            return SegmentViewModel(title: $0.element, subtitle: subtitles[$0.offset])
        }
        return viewModels
    }
}

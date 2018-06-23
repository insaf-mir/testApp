//
//  SegmentedView.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 23.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import RxSwift

struct SegmentViewModel {
    let title: String
    let subtitle: String
}

class SegmentView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    var selected: Bool = false {
        didSet {
            titleLabel.textColor = .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        subtitleLabel.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SegmentedView: UIView {
    private var titleViews: [SegmentView] = []
    var selectedSegmentIndex: Int = 0 {
        didSet {
            if titleViews.isEmpty {
                return
            }
            titleViews.forEach {
                $0.selected = false
            }
            titleViews[selectedSegmentIndex].selected = true
            selectedSegmentObservable.value = selectedSegmentIndex
        }
    }
    let selectedSegmentObservable = Variable(0)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.clipsToBounds = false
        stack.spacing = 15
        return stack
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    func configure(with viewModels: [SegmentViewModel]) {
        titleViews.forEach {
            $0.removeFromSuperview()
            stackView.removeArrangedSubview($0)
        }
        titleViews = []
        titleViews = viewModels.reduce([SegmentView]()) { current, next -> [SegmentView] in
            let segment = SegmentView()
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            segment.addGestureRecognizer(tapRecognizer)
            segment.titleLabel.text = next.title
            segment.subtitleLabel.text = next.subtitle
            return current + [segment]
        }
        
        titleViews.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.height.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.height.edges.equalToSuperview()
        }
    }
    
    @objc
    func handleTap(_ recognizer: UIGestureRecognizer) {
        guard
            let view = recognizer.view as? SegmentView,
            let index = titleViews.index(of: view)
            else { return }
        selectedSegmentIndex = index
        changeContentOffsetIfNeeded(view: view)
    }
    
    private func changeContentOffsetIfNeeded(view: UIView) {
        let viewFrame = view.convert(view.bounds, to: nil)
        var screenBounds = UIScreen.main.bounds
        // magic numbers
        screenBounds.origin.x = 10
        screenBounds.size = CGSize(width: screenBounds.width - 20, height: screenBounds.height)
        if screenBounds.contains(viewFrame) {
            return
        }
        var diff: CGFloat
        if viewFrame.origin.x < 0 {
            diff = viewFrame.origin.x - 50
            if diff + scrollView.contentOffset.x < 0 {
                diff = -scrollView.contentOffset.x
            }
        } else {
            diff = (viewFrame.maxX - UIScreen.main.bounds.width) + 50
            if diff + scrollView.contentOffset.x + scrollView.bounds.width > scrollView.contentSize.width {
                diff -= (diff + scrollView.contentOffset.x + scrollView.bounds.width - scrollView.contentSize.width)
            }
        }
        let contentOffset = CGPoint(x: scrollView.contentOffset.x + diff, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


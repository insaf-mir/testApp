//
//  UINavigationBarExtension.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 23.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

extension UIViewController {
    func configureDefaultNavigationItem(for navigationItem: UINavigationItem) -> UINavigationItem {        
        let backButton = UIButton()
        backButton.addTarget(self, action: #selector(popViewControllerAnimated), for: .touchUpInside)
        backButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backButton.contentHorizontalAlignment = .left
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        return navigationItem
    }
    
    @objc
    fileprivate func popViewControllerAnimated() {
        navigationController?.popViewController(animated: true)
    }
}

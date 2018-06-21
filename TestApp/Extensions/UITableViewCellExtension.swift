//
//  UITableViewCellExtension.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 21.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var dlReuseIdentifier: String {
        return String(describing: self)
    }
}

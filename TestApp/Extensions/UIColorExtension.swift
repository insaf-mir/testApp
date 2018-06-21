//
//  UIColorExtension.swift
//  TestApp
//
//  Created by Инсаф Мухаметшин on 21.06.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

extension UIColor {
    static func colorFromHex(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0,
            green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0,
            blue: ((CGFloat)(rgbValue & 0xFF))/255.0,
            alpha: 1
        )
    }
}

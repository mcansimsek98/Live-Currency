//
//  UIScreen+Extension.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}

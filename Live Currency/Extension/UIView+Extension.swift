//
//  UIView+Extension.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

extension UIView {
    func addSubViews(_ view: UIView...) {
        view.forEach({
            addSubview($0)
        })
    }
}

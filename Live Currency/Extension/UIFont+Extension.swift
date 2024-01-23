//
//  UIFont+Extension.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

extension UIFont {
    var boldVersion: UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(.traitBold) else {
            return self // If a bold version cannot be created, it returns the original font.
        }
        return UIFont(descriptor: descriptor, size: .zero) // .zero is keep to orginal size
    }
}

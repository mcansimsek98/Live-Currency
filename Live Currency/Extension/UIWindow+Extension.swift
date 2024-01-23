//
//  UIWindow+Extension.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}

//
//  Theme.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

struct Theme {
    let themeColor: ThemeColor
    let themeFont: ThemeFont
}

struct ThemeColor {
    let primaryColor: UIColor
    let secondaryColor: UIColor
    let buttonBackgroundColor: UIColor
    let textColor: UIColor
    let backgroundColor: UIColor
    let background2Color: UIColor
    let background3Color: UIColor

}

struct ThemeFont {
    let headlineFont: UIFont
    let bodyFont: UIFont
    let caption: UIFont
    let smallCaption: UIFont
}

extension Theme {
    static var defaultTheme: Theme {
        return Theme(
            themeColor: ThemeColor( primaryColor: .white,
                                    secondaryColor: .gray,
                                    buttonBackgroundColor: UIColor.buttonBackground,
                                    textColor: .white,
                                    backgroundColor: UIColor.background,
                                    background2Color: UIColor.background2,
                                    background3Color: UIColor.background3),
            themeFont: ThemeFont(
                headlineFont: UIFont(name: "San Francisco", size: FontSize.headline.rawValue) ?? .systemFont(ofSize: FontSize.headline.rawValue),
                bodyFont: .systemFont(ofSize: FontSize.body.rawValue),
                caption: .systemFont(ofSize: FontSize.caption.rawValue),
                smallCaption: .systemFont(ofSize: FontSize.smallCaption.rawValue))
            
        )
    }
}

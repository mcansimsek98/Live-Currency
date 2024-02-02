//
//  CustomInfoView.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 3.02.2024.
//

import UIKit

class CustomInfoView: UIView {
    private lazy var textLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = Theme.defaultTheme.themeFont.bodyFont
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var text: String? {
        didSet {
            textLbl.text = text
        }
    }
    
    init(height: CGFloat = 35,
         color: UIColor = Theme.defaultTheme.themeColor.background2Color,
         lblColor: UIColor = Theme.defaultTheme.themeColor.textColor,
         font: UIFont = Theme.defaultTheme.themeFont.bodyFont ) {
        super.init(frame: .zero)
        configure(height)
        backgroundColor = color
        textLbl.font = font
        textLbl.textColor = lblColor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLbl)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            
            textLbl.topAnchor.constraint(equalTo: topAnchor),
            textLbl.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -Padding.small.rawValue),
            textLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: Padding.medium.rawValue)
        ])
    }
}

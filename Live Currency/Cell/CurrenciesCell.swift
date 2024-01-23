//
//  CurrenciesCell.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

final class CurrenciesCell: UITableViewCell {
    private lazy var imageViewCell: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = Theme.defaultTheme.themeFont.bodyFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private func configureConstraint() {
        backgroundColor = .clear
        addSubViews(imageViewCell, titleLbl)
        NSLayoutConstraint.activate([
            imageViewCell.topAnchor.constraint(equalTo: topAnchor, constant: Padding.medium.rawValue),
            imageViewCell.leftAnchor.constraint(equalTo: leftAnchor, constant: Padding.medium.rawValue),
            imageViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.medium.rawValue),
            imageViewCell.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: Padding.small.rawValue),
            titleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -Padding.medium.rawValue),
            titleLbl.leftAnchor.constraint(equalTo: imageViewCell.rightAnchor, constant: Padding.small.rawValue),
            titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.small.rawValue)
        ])
    }
    
    public func configure(image: UIImage?, title: String) {
        imageViewCell.image = image
        titleLbl.text = title
        configureConstraint()
    }
}

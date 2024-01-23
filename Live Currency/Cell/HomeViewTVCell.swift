//
//  HomeViewTVCell.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import UIKit

class HomeViewTVCell: UITableViewCell {
    private lazy var contentview: UIView = {
        let view = UIView()
        view.backgroundColor = .background3
        view.layer.cornerRadius = Padding.medium.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = Theme.defaultTheme.themeFont.bodyFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var fromLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = Theme.defaultTheme.themeFont.bodyFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var arrowRightIV: UIImageView = {
        let img = UIImageView(image: .arrowRight)
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var toLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.bodyFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var stackView: UIStackView = {
        let stv = UIStackView()
        stv.axis = .horizontal
        stv.distribution = .fillEqually
        stv.spacing = Padding.small.rawValue
        stv.addArrangedSubview(titleLbl)
        stv.addArrangedSubview(fromLbl)
        stv.addArrangedSubview(arrowRightIV)
        stv.addArrangedSubview(toLbl)
        stv.translatesAutoresizingMaskIntoConstraints = false
        return stv
    }()
    
    private func configureConstraint() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(contentview)
        contentview.addSubViews(stackView)

        NSLayoutConstraint.activate([
            contentview.topAnchor.constraint(equalTo: topAnchor, constant: Padding.small.rawValue),
            contentview.rightAnchor.constraint(equalTo: rightAnchor, constant: -Padding.medium.rawValue),
            contentview.leftAnchor.constraint(equalTo: leftAnchor, constant: Padding.medium.rawValue),
            contentview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.small.rawValue),
            
            stackView.topAnchor.constraint(equalTo: contentview.topAnchor, constant: Padding.large.rawValue),
            stackView.rightAnchor.constraint(equalTo: contentview.rightAnchor, constant: -Padding.small.rawValue),
            stackView.leftAnchor.constraint(equalTo: contentview.leftAnchor, constant: Padding.medium.rawValue),
            stackView.bottomAnchor.constraint(equalTo: contentview.bottomAnchor, constant: -Padding.large.rawValue),
        ])
    }
    
    public func configure(title: String, from: String, to: String) {
        titleLbl.text = title
        fromLbl.text = from
        toLbl.text = to
        configureConstraint()
    }
}

//
//  WelcomeView.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func arrowRightBtnAction()
}

final class WelcomeView: UIView {
    weak var delegate: WelcomeViewDelegate?
    
    private let headerText = "Welcome to the application 🏁"
    private let wellcomeText = "You can use this application to learn, convert, and view exchange rates."
    
    private lazy var onBoardImage: UIImageView = {
        let img = UIImageView(image: .onboard)
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var headerLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = headerText
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.headlineFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var wellcomeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = wellcomeText
        lbl.numberOfLines = 0
        lbl.font = Theme.defaultTheme.themeFont.caption.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var arrowRightBtn: UIButton = {
        let btn = UIButton()
        btn.setImage( .arrowRight, for: .normal)
        btn.setTitleColor(Theme.defaultTheme.themeColor.textColor, for: .normal)
        btn.backgroundColor = .buttonBackground
        btn.layer.cornerRadius = Radius.small.rawValue
        btn.addAction(arrowRightBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var arrowRightBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        delegate?.arrowRightBtnAction()
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Theme.defaultTheme.themeColor.backgroundColor
        addSubViews(headerLbl, onBoardImage, wellcomeLbl, arrowRightBtn)
        configureConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            headerLbl.bottomAnchor.constraint(equalTo: onBoardImage.topAnchor, constant: -Padding.extraLarge.rawValue * 1.4),
            headerLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            
            onBoardImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            onBoardImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Padding.extraLarge.rawValue),
            onBoardImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            wellcomeLbl.bottomAnchor.constraint(equalTo: arrowRightBtn.topAnchor, constant: -Padding.extraLarge.rawValue),
            wellcomeLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            wellcomeLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            arrowRightBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Padding.large.rawValue),
            arrowRightBtn.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -Padding.medium.rawValue),
            arrowRightBtn.widthAnchor.constraint(equalToConstant: ButtonSize.extraLarge.rawValue),
            arrowRightBtn.heightAnchor.constraint(equalToConstant: ButtonSize.medium.rawValue),
        ])
    }
}

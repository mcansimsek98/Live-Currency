//
//  LoginView.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func continueBtnAction()
}

final class LoginView: UIView {
    weak var delegate: LoginViewDelegate?
    
    private let headerText = "Please enter your name to get started..."
    
    private lazy var headerLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = headerText
        lbl.numberOfLines = 1
        lbl.font = Theme.defaultTheme.themeFont.bodyFont
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var nameTFContentView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.defaultTheme.themeColor.background2Color
        view.layer.cornerRadius = Radius.small.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.addDoneButton()
        tf.backgroundColor = Theme.defaultTheme.themeColor.background2Color
        tf.textColor = Theme.defaultTheme.themeColor.textColor
        tf.attributedPlaceholder = NSAttributedString(string: "Name...",
                                                      attributes: [ .font: Theme.defaultTheme.themeFont.caption,
                                                                    .foregroundColor: Theme.defaultTheme.themeColor.secondaryColor])
        tf.layer.cornerRadius = Radius.small.rawValue
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var continueBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Continue ", for: .normal)
        btn.setImage( .arrowRight, for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.setTitleColor(Theme.defaultTheme.themeColor.textColor, for: .normal)
        btn.backgroundColor = .buttonBackground
        btn.layer.cornerRadius = Radius.small.rawValue
        btn.addAction(continueBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var continueBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        delegate?.continueBtnAction()
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Theme.defaultTheme.themeColor.backgroundColor
        addSubViews(headerLbl, nameTFContentView, continueBtn)
        nameTFContentView.addSubViews(nameTextField)
        configureConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            headerLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLbl.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Padding.extraLarge.rawValue * 2.6),
            headerLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            
            nameTFContentView.topAnchor.constraint(equalTo: headerLbl.bottomAnchor, constant: Padding.medium.rawValue),
            nameTFContentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTFContentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            nameTFContentView.heightAnchor.constraint(equalToConstant: ButtonSize.medium.rawValue),
            
            nameTextField.topAnchor.constraint(equalTo: nameTFContentView.topAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameTFContentView.bottomAnchor),
            nameTextField.leftAnchor.constraint(equalTo: nameTFContentView.leftAnchor, constant: Padding.large.rawValue),
            nameTextField.rightAnchor.constraint(equalTo: nameTFContentView.rightAnchor),
            
            continueBtn.topAnchor.constraint(equalTo: nameTFContentView.bottomAnchor, constant: Padding.extraLarge.rawValue),
            continueBtn.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -Padding.medium.rawValue),
            continueBtn.widthAnchor.constraint(equalToConstant: ButtonSize.extraLarge.rawValue * 1.3),
            continueBtn.heightAnchor.constraint(equalToConstant: ButtonSize.medium.rawValue),
        ])
    }
}

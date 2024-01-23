//
//  DetailVC.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import UIKit

protocol DetailVCDelegate: AnyObject {
    var presenter: DetailPresenterDelegate? { get set }
    var unitName: String? { get set }
}

class DetailVC: BaseVC, DetailVCDelegate {
    var presenter: DetailPresenterDelegate?
    var unitName: String?
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.back, for: .normal)
        btn.addAction(backBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.headlineFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var backBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        goBackAction()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.defaultTheme.themeColor.backgroundColor
        view.addSubViews(backBtn, titleLbl)
        
        titleLbl.text = unitName
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.large.rawValue),
            backBtn.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Padding.medium.rawValue),
            
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.large.rawValue),
            titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        ])
    }
}

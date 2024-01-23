//
//  OnboardVC.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import UIKit

protocol OnboardVCDelegate: AnyObject {
    var presenter: OnBoardPresenterDelegate? { get set }
}

final class OnboardVC: BaseVC, OnboardVCDelegate {
    var presenter: OnBoardPresenterDelegate?
    private let wellcomeView = WelcomeView()
    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        [wellcomeView, loginView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.topAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                $0.leftAnchor.constraint(equalTo: view.leftAnchor),
                $0.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        }

        loginView.isHidden = true
        loginView.delegate = self
        wellcomeView.delegate = self
    }
}

extension OnboardVC: WelcomeViewDelegate, LoginViewDelegate {
    func arrowRightBtnAction() {
        let transitionOptions: UIView.AnimationOptions = [.transitionCurlUp, .showHideTransitionViews]
        UIView.transition(from: wellcomeView, to: loginView, duration: 0.8, options: transitionOptions) { [weak self] _ in
            guard let self else { return }
            wellcomeView.isHidden = true
            loginView.isHidden = false
        }
    }

    func continueBtnAction() {
        presenter?.saveUser(name: loginView.nameTextField.text ?? "")
    }
}

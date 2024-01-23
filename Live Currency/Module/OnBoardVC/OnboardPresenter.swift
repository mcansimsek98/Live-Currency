//
//  OnboardPresenter.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import Foundation

protocol OnBoardPresenterDelegate: AnyObject {
    var router: OnboardRouterDelegate? { get set }
    var interactor: OnBoardInteractorDelegate? { get set }
    var view: OnboardVCDelegate? { get set }

    func navigatePage()
    func saveUser(name: String)
}

final class OnBoardPresenter: OnBoardPresenterDelegate {
    var router: OnboardRouterDelegate?
    var interactor: OnBoardInteractorDelegate?
    var view: OnboardVCDelegate?
    
    func navigatePage() {
        router?.navigateToMain(from: view)
    }
    
    func saveUser(name: String) {
        interactor?.saveUserAndStart(name: name)
    }
}

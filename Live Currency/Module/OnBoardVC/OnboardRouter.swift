//
//  OnboardRouter.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import UIKit

typealias OnboardEntryPoint = OnboardVCDelegate & UIViewController

protocol OnboardRouterDelegate: AnyObject {
    var entry: OnboardEntryPoint? { get }

    func navigateToMain(from view: OnboardVCDelegate?)
}

final class OnBoardRouter: OnboardRouterDelegate {
    var entry: OnboardEntryPoint?
    
    static func start() -> OnboardRouterDelegate {
        let router = OnBoardRouter()
        let view: OnboardVCDelegate = OnboardVC()
        let interactor: OnBoardInteractorDelegate = OnBoardInteractor()
        let presenter: OnBoardPresenterDelegate = OnBoardPresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? OnboardEntryPoint
        return router
    }
    
    func navigateToMain(from view: OnboardVCDelegate?) {
        let mainRouter = MainRouter.start()
        guard let vc = view as? UIViewController,
              let destinationVC = mainRouter.entry else { return }
        vc.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

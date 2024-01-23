//
//  MainRouter.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

typealias MainEntryPoint = MainVCDelegate & UIViewController

protocol MainRouterDelegate: AnyObject {
    var entry: MainEntryPoint? { get }
    
    static func start() -> MainRouterDelegate
    func navigateToDetail(from view: MainVCDelegate?, _ unitName: String)
}

class MainRouter: MainRouterDelegate {
    var entry: MainEntryPoint?

    static func start() -> MainRouterDelegate {
        let router = MainRouter()
        let view: MainVCDelegate = MainVC()
        let interactor: MainInteractorDelegate = MainInteractor()
        let presenter: MainPresenterDelegate = MainPresenter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? MainEntryPoint
        return router
    }
    
    func navigateToDetail(from view: MainVCDelegate?, _ unitName: String) {
        let detailRouter = DetailRouter.start(unitName: unitName)
        guard let vc = view as? UIViewController,
              let destinationVC = detailRouter.entry else { return }
        vc.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

//
//  DetailRouter.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import UIKit

typealias DetailEntryPoint = DetailVCDelegate & UIViewController

protocol DetailRouterDelegate: AnyObject {
    var entry: DetailEntryPoint? { get }
    static func start(unitName: String?) -> DetailRouterDelegate
}

class DetailRouter: DetailRouterDelegate {
    var entry: DetailEntryPoint?
    
    static func start(unitName: String?) -> DetailRouterDelegate {
        let router = DetailRouter()
        let view: DetailVCDelegate = DetailVC()
        let interactor: DetailInteractorDelegate = DetailInteractor()
        let presenter: DetailPresenterDelegate = DetailPresenter()
        
        view.presenter = presenter
        view.unitName = unitName
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? DetailEntryPoint
        return router
    }
}

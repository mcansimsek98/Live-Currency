//
//  DetailPresenter.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import Foundation

protocol DetailPresenterDelegate: AnyObject {
    var router: DetailRouterDelegate? { get set }
    var view: DetailVCDelegate? { get set }
    var interactor: DetailInteractorDelegate? { get set }
}

class DetailPresenter: DetailPresenterDelegate {
    var router: DetailRouterDelegate?
    var view: DetailVCDelegate?
    var interactor: DetailInteractorDelegate? 
}

//
//  DetailInteractor.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import Foundation

protocol DetailInteractorDelegate: AnyObject {
    var presenter: DetailPresenterDelegate? { get set }
    
}

class DetailInteractor: DetailInteractorDelegate {
    var presenter: DetailPresenterDelegate?
}

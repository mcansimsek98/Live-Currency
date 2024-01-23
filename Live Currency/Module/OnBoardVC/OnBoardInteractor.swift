//
//  OnBoardInteractor.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import Foundation

protocol OnBoardInteractorDelegate: AnyObject {
    var presenter: OnBoardPresenterDelegate? { get set }
    
    func saveUserAndStart(name: String)
}

class OnBoardInteractor: OnBoardInteractorDelegate {
    var presenter: OnBoardPresenterDelegate?
    
    func saveUserAndStart(name: String) {
        let standard = UserDefaults.standard
        standard.setValue(name, forKey: "name")
        standard.setValue(true, forKey: "isFirstEntry")
        standard.synchronize()
        
        presenter?.navigatePage()
    }
}

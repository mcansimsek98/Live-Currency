//
//  MainPresenter.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import Foundation

protocol MainPresenterDelegate: AnyObject {
    var router: MainRouterDelegate? { get set }
    var view: MainVCDelegate? { get set }
    var interactor: MainInteractorDelegate? { get set }
    
    func interactorDidFetchCurrency(with result: Result<MainEntity, Error>)
    func updateCurencies(from: String)
    func convertCurrencies(from: String, to: String, amount: Int)
}

class MainPresenter: MainPresenterDelegate {
    var router: MainRouterDelegate?
    var view: MainVCDelegate?
    var interactor: MainInteractorDelegate? {
        didSet {
            interactor?.getAllCurency(from: "TRY")
        }
    }
    
    func updateCurencies(from: String) {
        interactor?.getAllCurency(from: from)
    }
    
    func interactorDidFetchCurrency(with result: Result<MainEntity, Error>) {
        switch result {
        case .success(let currencies):
            let data = currencies.results?.compactMap { key, value in
                return MainEntityResult(key: key, value: value)
            } ?? []

            let targetCurrencies = ["USD", "EUR", "TRY"]
            let (targets, others) = data.reduce(into: ([MainEntityResult](), [MainEntityResult]())) { result, element in
                targetCurrencies.contains(element.key) ? result.0.append(element) : result.1.append(element)
            }

            let sortedTargets = targets.sorted { target1, target2 in
                guard let index1 = targetCurrencies.firstIndex(of: target1.key),
                      let index2 = targetCurrencies.firstIndex(of: target2.key) else {
                    return false
                }
                return index1 < index2
            }

            let sortedData = sortedTargets + others.sorted { $0.key < $1.key }
            view?.update(with: currencies, list: sortedData)
        case .failure:
            view?.update(with: "Somting went wrong")
        }
    }
    
    func convertCurrencies(from: String, to: String, amount: Int) {
        
    }
}

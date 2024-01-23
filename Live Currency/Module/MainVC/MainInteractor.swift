//
//  MainInteractor.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import Foundation
import Combine

protocol MainInteractorDelegate: AnyObject {
    var presenter: MainPresenterDelegate? { get set }
    
    func getAllCurency(from: String)
}

class MainInteractor: MainInteractorDelegate {
    var presenter: MainPresenterDelegate?
    var cancellables = Set<AnyCancellable>()

    func getAllCurency(from: String) {
        NetworkManager.shared.fetchAllCurrencies(from: from).sink(
            receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    print("Currencies fetched successfully.")
                case .failure(let error):
                    presenter?.interactorDidFetchCurrency(with: .failure(error))
                }
            },
            receiveValue: { [weak self] (response: MainEntity)  in
                guard let self else { return }
                presenter?.interactorDidFetchCurrency(with: .success(response))
            }).store(in: &cancellables)

    }
}

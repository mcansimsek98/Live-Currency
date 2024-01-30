//
//  DetailInteractor.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import Foundation
import Combine

protocol DetailInteractorDelegate: AnyObject {
    var presenter: DetailPresenterDelegate? { get set }
    
    func getTimeSerius(from: String, to: String)
}

class DetailInteractor: DetailInteractorDelegate {
    var presenter: DetailPresenterDelegate?
    var cancellables = Set<AnyCancellable>()

    func getTimeSerius(from: String, to: String) {
        NetworkManager.shared.getTimeSerius(from: from, to: to).sink(
            receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    print("Currencies fetched successfully.")
                case .failure(let error):
                    presenter?.interactorDidFetchTimeSerius(with: .failure(error))
                }
            },
            receiveValue: { [weak self] (response: TimeSeriusEntity)  in
                guard let self else { return }
                presenter?.interactorDidFetchTimeSerius(with: .success(response))
            }).store(in: &cancellables)
    }
}

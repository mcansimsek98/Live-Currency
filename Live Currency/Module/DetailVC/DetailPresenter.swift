//
//  DetailPresenter.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import Foundation
import Charts
import DGCharts

protocol DetailPresenterDelegate: AnyObject {
    var router: DetailRouterDelegate? { get set }
    var view: DetailVCDelegate? { get set }
    var interactor: DetailInteractorDelegate? { get set }
    
    func interactorDidFetchTimeSerius(with result: Result<TimeSeriusEntity, Error>)
}

class DetailPresenter: DetailPresenterDelegate {
    var router: DetailRouterDelegate?
    var view: DetailVCDelegate?
    var interactor: DetailInteractorDelegate? {
        didSet {
            interactor?.getTimeSerius(from: view?.from ?? "", to: view?.unitName ?? "")
        }
    }
    
    func interactorDidFetchTimeSerius(with result: Result<TimeSeriusEntity, Error>) {
        switch result {
        case .success(let data):
            guard let result = data.results?.first?.value else { return }
            
            let chartData = result.compactMap({ item in
                ChartDataEntry(x: Double(item.key.suffix(2)) ?? 0, y: item.value)
            }).sorted(by: {$0.x < $1.x})
            
            view?.update(with: data, list: chartData)
            break
        case .failure:
            view?.update(with: "Somting went wrong")
            break
        }
    }
}

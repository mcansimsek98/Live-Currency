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
    
    func updateCurencies(from: String, to: String)
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
    
    func updateCurencies(from: String, to: String) {
        interactor?.getTimeSerius(from: from, to: to)
    }
    
    func interactorDidFetchTimeSerius(with result: Result<TimeSeriusEntity, Error>) {
        switch result {
        case .success(let data):
            guard let result = data.results?.first?.value else { return }
            
            var index: Double = 0
            let barChartData = result.sorted(by: {$0.key < $1.key}).map({
                index += 1
                return BarChartDataEntry(x: index, y: $0.value)
            })
            
            let lineChartData = result.compactMap({ChartDataEntry(x: Date.getDateDouble($0.key), y: $0.value)}).sorted(by: {$0.x < $1.x})
            let barFormater = IndexAxisValueFormatter(values: result.sorted(by: {$0.key < $1.key}).map {Date.convertDate(date: $0.key, outputFormat: "dd.MM")})
            let tuple = (lineChartData, barChartData, barFormater)
            view?.update(with: data, list: tuple)
            break
        case .failure:
            view?.update(with: "Somting went wrong")
            break
        }
    }
}

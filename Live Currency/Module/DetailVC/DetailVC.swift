//
//  DetailVC.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 23.01.2024.
//

import UIKit
import Charts
import DGCharts

protocol DetailVCDelegate: AnyObject {
    var presenter: DetailPresenterDelegate? { get set }
    var unitName: String? { get set }
    var from: String? { get set }
    
    func update(with currencies: TimeSeriusEntity?, list: [ChartDataEntry])
    func update(with error: String)
}

class DetailVC: BaseVC, DetailVCDelegate {
    var presenter: DetailPresenterDelegate?
    var unitName: String?
    var from: String?
    private var detailView: DetailView?

    override func loadView() {
        super.loadView()
        detailView = DetailView(from: from, unitName: unitName)
        view = detailView
        detailView?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func update(with currencies: TimeSeriusEntity?, list: [ChartDataEntry]) {
        detailView?.configureChart(dataEntries: list)
    }
    
    func update(with error: String) {
        presentAlert(message: error)
    }
}

extension DetailVC: DetailViewActionDelegate {
    func backBtnAction() {
        goBackAction()
    }
}

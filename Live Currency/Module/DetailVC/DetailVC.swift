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
    
    func update(with currencies: TimeSeriusEntity?, list: ([ChartDataEntry], [BarChartDataEntry], IndexAxisValueFormatter))
    func update(with error: String)
}

class DetailVC: BaseVC, DetailVCDelegate {
    var presenter: DetailPresenterDelegate?
    var unitName: String?
    var from: String?
    private lazy var selectedUnit: [String] = [unitName ?? "---"]
    private var detailView: DetailView?

    override func loadView() {
        super.loadView()
        detailView = DetailView()
        view = detailView
        detailView?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func update(with currencies: TimeSeriusEntity?, list: ([ChartDataEntry], [BarChartDataEntry], IndexAxisValueFormatter)) {
        detailView?.dataEntries = list
        detailView?.updateChart()
        detailView?.updateInfoView(currencies, from, unitName)
    }
    
    func update(with error: String) {
        presentAlert(message: error)
    }
}

extension DetailVC: DetailViewActionDelegate {
    func unitSelectBtnAction() {
        let currencyList = CurrenciesList.unitList.compactMap({(AlertData(image: $0.image, title: $0.name, description: $0.fullName))}).filter({ $0.title != from ?? ""})
        UIAlertController.showCustomAlert(title: "Please select currency",
                                          message: nil,
                                          items: currencyList,
                                          selectedItems: selectedUnit,
                                          presentingViewController: self)
        { [weak self] item, index in
            guard let self else { return }
            detailView?.titleLbl.text = item
            selectedUnit = [item ?? "---"]
            unitName = item
            detailView?.chartDataInfoLbl.text = "\(from ?? "") to \(item ?? "") Rate Chart"

            presenter?.updateCurencies(from: from ?? "", to: item ?? "")
            dismiss(animated: true)
        }
    }
    
    func backBtnAction() {
        goBackAction()
    }
}

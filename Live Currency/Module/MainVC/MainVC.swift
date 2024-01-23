//
//  MainVC.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

protocol MainVCDelegate: AnyObject {
    var presenter: MainPresenterDelegate? { get set }
    func update(with currencies: MainEntity, list: [MainEntityResult])
    func update(with error: String)
}

class MainVC: BaseVC, MainVCDelegate {
    var presenter: MainPresenterDelegate?
    private let homeView = HomeView()
    private var selectedUnitFrom: [String] = ["TRY"]
    private var selectedUnitTo: [String] = ["---"]
    private var currenciesList: [MainEntityResult] = []
    private var filteredCurrenciesList: [MainEntityResult] = []
    
    override func loadView() {
        super.loadView()
        view = homeView
        homeView.delegate = self
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func update(with currencies: MainEntity, list: [MainEntityResult]) {
        currenciesList = list.filter({$0.key != selectedUnitFrom.first})
        filteredCurrenciesList = list.filter({$0.key != selectedUnitFrom.first})
        homeView.tableView.reloadData()
        homeView.updateTime = currencies.updated ?? ""
    }
    
    func update(with error: String) {
        filteredCurrenciesList = []
        homeView.tableView.reloadData()
        presentAlert(message: error)
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrenciesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTVCell", for: indexPath) as! HomeViewTVCell
        let item = filteredCurrenciesList.compactMap({ ($0.key, $0.value)})[indexPath.row]
        let from = "\(homeView.amountTextField.text ?? "1") \(homeView.unitLabel.text ?? "TRY")"
        let to = selectedUnitTo.first == "---" ? (item.1 * 1) : (item.1 * (Double(homeView.amountTextField.text ?? "1") ?? 1))
        cell.configure(title: item.0, from: from, to: "\(String(format: "%.3f", to))")
        return cell
    }
}

//MARK: HomeViewDelegate
extension MainVC: HomeViewDelegate {
    func searchBtnAction(with searchText: String) {
        guard searchText.count != 0 else {
            filteredCurrenciesList = currenciesList
            homeView.tableView.reloadData()
            return
        }
        filteredCurrenciesList = filteredCurrenciesList.filter({$0.key.contains(searchText)})
        homeView.tableView.reloadData()
    }
    
    func unitBtnAction() {
        UIAlertController.showCustomAlert(title: "Please select currency",
                                          message: nil,
                                          items: CurrenciesList.unitList.compactMap({($0.image, $0.name)}),
                                          selectedItems: selectedUnitFrom,
                                          presentingViewController: self)
        { [weak self] item, index in
            guard let self else { return }
            homeView.unitLabel.text = item
            selectedUnitFrom = [item ?? "TRY"]
            presenter?.updateCurencies(from: item ?? "TRY")
            dismiss(animated: true)
        }
    }
    
    func unitSecondBtnAction() {
        var list = CurrenciesList.unitList.compactMap({($0.image, $0.name)})
        list.insert((.currencyIcon, "---"), at: 0)
        UIAlertController.showCustomAlert(title: "Please select currency",
                                          message: nil,
                                          items: list,
                                          selectedItems: selectedUnitTo,
                                          presentingViewController: self)
        { [weak self] item, index in
            guard let self else { return }
            homeView.unitSecondLabel.text = item
            selectedUnitTo = [item ?? "TRY"]
            
            item == "---" ? presenter?.updateCurencies(from: selectedUnitFrom.first ?? "TRY")
            : presenter?.convertCurrencies(from: selectedUnitFrom.first ?? "", to: item ?? "", amount: Int(homeView.amountTextField.text ?? "1") ?? 1)
            dismiss(animated: true)
        }
    }
}

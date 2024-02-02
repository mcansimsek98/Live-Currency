//
//  MainVC.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

protocol MainVCDelegate: AnyObject {
    var presenter: MainPresenterDelegate? { get set }
    func update(with currencies: MainEntity?, list: [MainEntityResult])
    func update(with error: String)
}

class MainVC: BaseVC, MainVCDelegate {
    var presenter: MainPresenterDelegate?
    private let homeView = HomeView()
    private var selectedUnitFrom: [String] = ["EUR"]
    private var selectedUnitTo: [String] = ["---"]
    private var currenciesList: [MainEntityResult] = []
    private var filteredCurrenciesList: [MainEntityResult] = []
    
    override func loadView() {
        super.loadView()
        view = homeView
        homeView.delegate = self
        homeView.amountTextField.delegate = self
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func update(with currencies: MainEntity?, list: [MainEntityResult]) {
        let data = list.filter({$0.key != selectedUnitFrom.first})
        let amount = Double(homeView.amountTextField.text ?? "1") ?? 1
        currenciesList = data.compactMap({MainEntityResult(key: $0.key, value: $0.value * amount)})
        filteredCurrenciesList = data.compactMap({MainEntityResult(key: $0.key, value: $0.value * amount)})
        homeView.updateTime = currencies?.updated ?? ""
        homeView.tableView.reloadData()
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
        let from = "\(homeView.amountTextField.text ?? "1") \(homeView.unitLabel.text ?? "---")"
        cell.configure(title: item.0, from: from, to: String(format: "%.2f", item.1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredCurrenciesList.compactMap({ ($0.key, $0.value)})[indexPath.row]
        presenter?.gotoDetailVC(unitName: item.0, from: homeView.unitLabel.text ?? "")
    }
}

//MARK: HomeViewDelegate
extension MainVC: HomeViewDelegate {
    func refreshButtonAction() {
        homeView.amountTextField.text = "1"
        homeView.unitSecondLabel.text = "---"
        selectedUnitTo = []
        presenter?.interactor?.getAllCurency(from: homeView.unitLabel.text ?? "---")
    }
    
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
                                          items: CurrenciesList.unitList.compactMap({AlertData(image: $0.image, title: $0.name, description: $0.fullName)}),
                                          selectedItems: selectedUnitFrom,
                                          presentingViewController: self)
        { [weak self] item, index in
            guard let self else { return }
            homeView.unitLabel.text = item
            selectedUnitFrom = [item ?? "---"]
            homeView.unitSecondLabel.text = "---"
            selectedUnitTo = []
            presenter?.updateCurencies(from: item ?? "---")
            dismiss(animated: true)
        }
    }
    
    func unitSecondBtnAction() {
        var list = CurrenciesList.unitList.compactMap({AlertData(image: $0.image, title: $0.name, description: $0.fullName)})
        list.insert(AlertData(image: .currencyIcon, title: "---", description: ""), at: 0)
        UIAlertController.showCustomAlert(title: "Please select currency",
                                          message: nil,
                                          items: list,
                                          selectedItems: selectedUnitTo,
                                          presentingViewController: self)
        { [weak self] item, index in
            guard let self else { return }
            homeView.unitSecondLabel.text = item
            selectedUnitTo = [item ?? "---"]
            
            filteredCurrenciesList = selectedUnitTo.first == "---" ? currenciesList : currenciesList.filter({$0.key.contains(item ?? "---")})
            homeView.tableView.reloadData()
            dismiss(animated: true)
        }
    }
}

extension MainVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, text.count != 0 else {
            filteredCurrenciesList = currenciesList
            homeView.tableView.reloadData()
            return
        }
        let list = selectedUnitTo.first == "---" ? currenciesList : currenciesList.filter({$0.key.contains(selectedUnitTo.first ?? "---")})
        filteredCurrenciesList = list.compactMap({MainEntityResult(key: $0.key, value: $0.value * (Double(text) ?? 1))})
        homeView.tableView.reloadData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text?.count == 0 else {
            return
        }
        filteredCurrenciesList = currenciesList
        homeView.amountTextField.text = "1"
        homeView.tableView.reloadData()
    }
}

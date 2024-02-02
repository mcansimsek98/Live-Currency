//
//  CustomAlertTableViewWithCompletion.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

class CustomAlertTableViewWithCompletion: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var items: [AlertData] = []
    var selectedItems: [String] = []
    var hasSubtitle: Bool = false
    var didSelectItemHandler: ((String?, Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.tintColor = Theme.defaultTheme.themeColor.secondaryColor
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CurrenciesCell.self, forCellReuseIdentifier: "CurrenciesCell")

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrenciesCell", for: indexPath) as! CurrenciesCell
        let item = items[indexPath.row]
        cell.configure(image: item.image, title: item.title, description: item.description)
        cell.accessoryType = item.title == selectedItems.first ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row].title
        didSelectItemHandler?(selectedItem, indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Padding.extraLarge.rawValue * 1.3
    }
}

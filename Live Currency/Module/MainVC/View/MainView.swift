//
//  MainView.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func searchBtnAction(with searchText: String)
    func unitBtnAction()
    func unitSecondBtnAction()
    func refreshButtonAction()
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    
    private lazy var filterButton: UIButton = {
        let btn = UIButton()
        btn.setImage( .filterIcon, for: .normal)
        btn.setTitleColor(Theme.defaultTheme.themeColor.textColor, for: .normal)
        btn.backgroundColor = .clear
        btn.addAction(filterBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var profileTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = UserDefaults.standard.string(forKey: "name")
        lbl.font = Theme.defaultTheme.themeFont.headlineFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var welcomeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Wellcome!"
        lbl.font = Theme.defaultTheme.themeFont.caption
        lbl.textColor = Theme.defaultTheme.themeColor.secondaryColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var searchContentView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.defaultTheme.themeColor.background2Color
        view.layer.cornerRadius = Radius.small.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.addDoneButton()
        tf.backgroundColor = Theme.defaultTheme.themeColor.background2Color
        tf.autocapitalizationType = .allCharacters
        tf.textColor = Theme.defaultTheme.themeColor.textColor
        tf.attributedPlaceholder = NSAttributedString(string: "Search...",
                                                      attributes: [.foregroundColor: Theme.defaultTheme.themeColor.secondaryColor])
        tf.layer.cornerRadius = Radius.small.rawValue
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage( .search, for: .normal)
        btn.setTitleColor(Theme.defaultTheme.themeColor.textColor, for: .normal)
        btn.backgroundColor = .background3
        btn.layer.cornerRadius = Radius.small.rawValue
        btn.addAction(searchBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var amountTextField: UITextField = {
        let tf = UITextField()
        tf.text = "1"
        tf.addDoneButton()
        tf.textAlignment = .center
        tf.backgroundColor = Theme.defaultTheme.themeColor.background2Color
        tf.textColor = Theme.defaultTheme.themeColor.textColor
        tf.keyboardType = .numberPad
        tf.layer.cornerRadius = Radius.small.rawValue
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var unitLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "TRY"
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.caption
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var unitButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = Radius.small.rawValue
        btn.addAction(unitBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var fromLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "From"
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.smallCaption
        lbl.textColor = Theme.defaultTheme.themeColor.secondaryColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var unitContentView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.defaultTheme.themeColor.background2Color
        view.layer.cornerRadius = Radius.small.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var toLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "To"
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.smallCaption
        lbl.textColor = Theme.defaultTheme.themeColor.secondaryColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var unitSecondLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "---"
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.caption
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var unitSecondButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = Radius.small.rawValue
        btn.addAction(unitSecondBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var unitSecondContentView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.defaultTheme.themeColor.background2Color
        view.layer.cornerRadius = Radius.small.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(HomeViewTVCell.self, forCellReuseIdentifier: "HomeViewTVCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var filterContetnView: UIStackView = {
        let stv = UIStackView()
        stv.axis = .horizontal
        stv.isHidden = true
        stv.alpha = 0
        stv.distribution = .fillEqually
        stv.spacing = Padding.medium.rawValue
        stv.addArrangedSubview(amountTextField)
        stv.addArrangedSubview(unitContentView)
        stv.addArrangedSubview(unitSecondContentView)
        stv.translatesAutoresizingMaskIntoConstraints = false
        return stv
    }()
    
    private lazy var contentViewForSearchAndFilter: UIStackView = {
        let stv = UIStackView()
        stv.axis = .vertical
        stv.distribution = .equalSpacing
        stv.spacing = Padding.large.rawValue
        stv.addArrangedSubview(searchContentView)
        stv.addArrangedSubview(filterContetnView)
        stv.translatesAutoresizingMaskIntoConstraints = false
        return stv
    }()
    
    private lazy var updateLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = Theme.defaultTheme.themeFont.smallCaption
        lbl.textColor = Theme.defaultTheme.themeColor.secondaryColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var filterBtnAction: UIAction = UIAction { _ in
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self else { return }
            filterContetnView.isHidden = !filterContetnView.isHidden
            filterContetnView.alpha = filterContetnView.isHidden ? 0 : 1
            filterButton.setImage(filterContetnView.isHidden ? .filterIcon : .closeFilter, for: .normal)
        }
    }
    
    private lazy var refreshButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.refresh, for: .normal)
        btn.transform = CGAffineTransform(rotationAngle: 0)
        btn.layer.cornerRadius = Radius.small.rawValue
        btn.addAction(refreshButtonAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var searchBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        delegate?.searchBtnAction(with: searchTextField.text ?? "")
    }
    
    private lazy var unitBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        delegate?.unitBtnAction()
    }
    
    private lazy var unitSecondBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        delegate?.unitSecondBtnAction()
    }
    
    private lazy var refreshButtonAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            for i in 0...8 {
                let startTime = Double(i) * 0.5 / 8.0
                let endTime = Double(i + 1) * 0.5 / 8.0

                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: endTime - startTime, animations: {
                    let rotationAngle: CGFloat = .pi / 4
                    self.refreshButton.transform = self.refreshButton.transform.rotated(by: rotationAngle)
                })
            }
        }, completion: nil)
        delegate?.refreshButtonAction()
    }
    
    lazy var updateTime: String = "" {
        didSet {
            let inputDateFormat = DateFormatter()
            inputDateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let outputDateFormat = DateFormatter()
            outputDateFormat.dateFormat = "dd.MM.yyyy HH:mm:ss"
            outputDateFormat.timeZone = TimeZone(secondsFromGMT: 3 * 60 * 60)
            
            if let inputDate = inputDateFormat.date(from: updateTime) {
                let gmt3Date = inputDate.addingTimeInterval(TimeInterval(TimeZone(secondsFromGMT: 3 * 60 * 60)?.secondsFromGMT(for: inputDate) ?? 0))
                let outputDateString = outputDateFormat.string(from: gmt3Date)
                updateLbl.text = "Updated: \(outputDateString)"
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Theme.defaultTheme.themeColor.backgroundColor
        addSubViews(filterButton, profileTitleLbl, welcomeLbl, refreshButton, contentViewForSearchAndFilter, updateLbl, tableView)
        searchContentView.addSubViews(searchTextField, searchButton)
        unitContentView.addSubViews(fromLbl, unitLabel, unitButton)
        unitSecondContentView.addSubViews(toLbl, unitSecondLabel, unitSecondButton)
        configureConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.small.rawValue),
            filterButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -Padding.large.rawValue),
            filterButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.08),
            
            welcomeLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.extraLarge.rawValue),
            welcomeLbl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Padding.medium.rawValue),
            
            profileTitleLbl.topAnchor.constraint(equalTo: welcomeLbl.bottomAnchor, constant: Padding.small.rawValue),
            profileTitleLbl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Padding.medium.rawValue),
            
            refreshButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.small.rawValue),
            refreshButton.rightAnchor.constraint(equalTo: filterButton.leftAnchor, constant: -Padding.large.rawValue),

            searchButton.topAnchor.constraint(equalTo: searchContentView.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: searchContentView.bottomAnchor),
            searchButton.rightAnchor.constraint(equalTo: searchContentView.rightAnchor),
            searchButton.widthAnchor.constraint(equalTo: searchContentView.widthAnchor, multiplier: 0.15),
            
            searchTextField.topAnchor.constraint(equalTo: searchContentView.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchContentView.bottomAnchor),
            searchTextField.leftAnchor.constraint(equalTo: searchContentView.leftAnchor, constant: Padding.large.rawValue),
            searchTextField.rightAnchor.constraint(equalTo: searchButton.leftAnchor),

            
            contentViewForSearchAndFilter.topAnchor.constraint(equalTo: profileTitleLbl.bottomAnchor, constant: Padding.large.rawValue),
            contentViewForSearchAndFilter.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentViewForSearchAndFilter.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            searchContentView.heightAnchor.constraint(equalToConstant: ButtonSize.medium.rawValue),
            filterContetnView.heightAnchor.constraint(equalToConstant: ButtonSize.medium.rawValue),

            
            fromLbl.topAnchor.constraint(equalTo: unitContentView.topAnchor, constant: 2.5),
            fromLbl.leftAnchor.constraint(equalTo: unitContentView.leftAnchor),
            fromLbl.rightAnchor.constraint(equalTo: unitContentView.rightAnchor),
            fromLbl.heightAnchor.constraint(equalTo: unitContentView.heightAnchor, multiplier: 0.22),

            unitLabel.topAnchor.constraint(equalTo: fromLbl.bottomAnchor, constant: 2),
            unitLabel.bottomAnchor.constraint(equalTo: unitContentView.bottomAnchor),
            unitLabel.rightAnchor.constraint(equalTo: unitContentView.rightAnchor),
            unitLabel.widthAnchor.constraint(equalTo: unitContentView.widthAnchor),
            
            unitButton.topAnchor.constraint(equalTo: unitContentView.topAnchor),
            unitButton.bottomAnchor.constraint(equalTo: unitContentView.bottomAnchor),
            unitButton.rightAnchor.constraint(equalTo: unitContentView.rightAnchor),
            unitButton.widthAnchor.constraint(equalTo: unitContentView.widthAnchor),
            
            toLbl.topAnchor.constraint(equalTo: unitSecondContentView.topAnchor, constant: 2.5),
            toLbl.leftAnchor.constraint(equalTo: unitSecondContentView.leftAnchor),
            toLbl.rightAnchor.constraint(equalTo: unitSecondContentView.rightAnchor),
            toLbl.heightAnchor.constraint(equalTo: unitSecondContentView.heightAnchor, multiplier: 0.22),
            
            unitSecondLabel.topAnchor.constraint(equalTo: toLbl.bottomAnchor, constant: 2),
            unitSecondLabel.bottomAnchor.constraint(equalTo: unitSecondContentView.bottomAnchor),
            unitSecondLabel.rightAnchor.constraint(equalTo: unitSecondContentView.rightAnchor),
            unitSecondLabel.widthAnchor.constraint(equalTo: unitSecondContentView.widthAnchor),
            
            unitSecondButton.topAnchor.constraint(equalTo: unitSecondContentView.topAnchor),
            unitSecondButton.bottomAnchor.constraint(equalTo: unitSecondContentView.bottomAnchor),
            unitSecondButton.rightAnchor.constraint(equalTo: unitSecondContentView.rightAnchor),
            unitSecondButton.widthAnchor.constraint(equalTo: unitSecondContentView.widthAnchor),
            
            
            updateLbl.topAnchor.constraint(equalTo: contentViewForSearchAndFilter.bottomAnchor, constant: Padding.medium.rawValue),
            updateLbl.rightAnchor.constraint(equalTo: searchContentView.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: updateLbl.bottomAnchor, constant: Padding.small.rawValue / 2),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
        ])
    }
}

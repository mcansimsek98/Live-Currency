//
//  Detailswift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 26.01.2024.
//

import UIKit
import Charts
import DGCharts

protocol DetailViewActionDelegate: AnyObject {
    func backBtnAction()
    func unitSelectBtnAction()
}

final class DetailView: UIView {
    weak var delegate: DetailViewActionDelegate?
    var dataEntries: ([ChartDataEntry], [BarChartDataEntry], IndexAxisValueFormatter)?
    var chartType: ChartType = .line
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.back, for: .normal)
        btn.addAction(backBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.bodyFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var downArrowView: UIImageView = {
        let img = UIImageView(image: .arrowDown)
        img.contentMode = .left
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var unitSelectBtn: UIButton = {
        let btn = UIButton()
        btn.addAction(unitSelectBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var unitContentView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.backgroundColor = Theme.defaultTheme.themeColor.background2Color
        view.layer.cornerRadius = Radius.small.rawValue
        view.addArrangedSubview(titleLbl)
        view.addArrangedSubview(downArrowView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var chartTypeSegment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(with: .bar, at: 0, animated: true)
        segment.insertSegment(with: .line, at: 1, animated: true)
        segment.selectedSegmentIndex = 1
        segment.selectedSegmentTintColor = Theme.defaultTheme.themeColor.background2Color
        segment.addTarget(self, action: #selector(chartTypeSegmentChanged(_:)), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    lazy var chartDataInfoLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = Theme.defaultTheme.themeFont.smallCaption
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var lineChartView: LineChartView = {
        let chart = LineChartView()
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.drawGridLinesBehindDataEnabled = true
        chart.leftAxis.drawAxisLineEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawLabelsEnabled = false
        chart.rightAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawLabelsEnabled = false
        chart.xAxis.valueFormatter = DateValueFormatter()
        chart.xAxis.labelRotationAngle = -60.0
        chart.isUserInteractionEnabled = false
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    private lazy var barChartView: BarChartView = {
        let chart = BarChartView()
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.drawGridLinesBehindDataEnabled = true
        chart.leftAxis.drawAxisLineEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawLabelsEnabled = false
        chart.rightAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.xAxis.labelRotationAngle = -60.0
        chart.borderColor = .white.withAlphaComponent(0.4)
        chart.barData?.barWidth = 10
        chart.isUserInteractionEnabled = false
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    private lazy var infoTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "LIVE DATA"
        lbl.font = Theme.defaultTheme.themeFont.bodyFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = Theme.defaultTheme.themeFont.smallCaption
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var headerContent: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.backgroundColor = Theme.defaultTheme.themeColor.background3Color
        view.addArrangedSubview(infoTitleLbl)
        view.addArrangedSubview(dateLbl)
        view.layoutMargins = UIEdgeInsets(top: 0, left: Padding.small.rawValue, bottom: 0, right: Padding.small.rawValue)
        view.isLayoutMarginsRelativeArrangement = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fromCurrencyLbl = CustomInfoView()
    private lazy var toCurrencyLbl = CustomInfoView()
    private lazy var startDateLbl = CustomInfoView()
    private lazy var endDateLbl = CustomInfoView()
    private lazy var lowestLbl = CustomInfoView()
    private lazy var highestLbl = CustomInfoView()
    private lazy var warningLbl: CustomInfoView = {
        let lbl = CustomInfoView(height: 90,
                                 color: .clear,
                                 lblColor: Theme.defaultTheme.themeColor.warningTextColor,
                                 font: Theme.defaultTheme.themeFont.caption)
        lbl.text = " ‼️ The information presented here is shown on a one unit basis. These values are for informational purposes only and may change instantly."
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var detailContent: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Padding.small.rawValue
        view.backgroundColor = .clear
        view.addArrangedSubview(headerContent)
        view.addArrangedSubview(fromCurrencyLbl)
        view.addArrangedSubview(toCurrencyLbl)
        view.addArrangedSubview(startDateLbl)
        view.addArrangedSubview(endDateLbl)
        view.addArrangedSubview(lowestLbl)
        view.addArrangedSubview(highestLbl)
        view.addArrangedSubview(warningLbl)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        delegate?.backBtnAction()
    }
    
    private lazy var unitSelectBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        delegate?.unitSelectBtnAction()
    }
    
    @objc private func chartTypeSegmentChanged(_ sender: UISegmentedControl) {
        chartType = sender.selectedSegmentIndex == 0 ? .bar : .line
        updateChart()
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Theme.defaultTheme.themeColor.backgroundColor
        addSubViews(backBtn, unitContentView, unitSelectBtn, chartTypeSegment, scrollView)
        scrollView.addSubViews(lineChartView, barChartView, chartDataInfoLbl, detailContent)
        configureConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func updateChart() {
        lineChartView.data = nil
        barChartView.data = nil
        lineChartView.isHidden = chartType == .bar
        barChartView.isHidden = chartType == .line
        chartTypeSegment.selectedSegmentIndex =  chartType == .bar ? 0 : 1
        
        guard let dataEntries else { return }
        switch chartType {
        case .bar:
            let dataSet = BarChartDataSet(entries: dataEntries.1, label: "")
            dataSet.colors = [UIColor.buttonBackground, UIColor.systemBlue]
            barChartView.xAxis.valueFormatter = dataEntries.2
            barChartView.animate(xAxisDuration: 0.8)
            barChartView.xAxis.labelCount = dataSet.count
            barChartView.data = BarChartData(dataSet: dataSet)
        case .line:
            let dataSet = LineChartDataSet(entries: dataEntries.0, label: "")
            dataSet.colors = [Theme.defaultTheme.themeColor.secondaryColor]
            dataSet.mode = .linear
            let gradientColors = [UIColor.systemBlue.cgColor, UIColor.black.cgColor] as CFArray
            let colorLocations: [CGFloat] = [1.0, 0.0]
            if let gradient = CGGradient(colorsSpace: nil, colors: gradientColors, locations: colorLocations) {
                dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
                dataSet.drawFilledEnabled = true
            }
            lineChartView.animate(xAxisDuration: 0.8)
            lineChartView.xAxis.labelCount = dataSet.count
            lineChartView.data = LineChartData(dataSet: dataSet)
        }
    }
    
    func updateInfoView(_ currencies: TimeSeriusEntity?, _ from: String?, _ unitName: String?) {
        titleLbl.text = unitName
        dateLbl.text = Date.getDateString(outputFormat: "dd.MM.yyyy HH:mm:ss")
        chartDataInfoLbl.text = "\(from ?? "") to \(unitName ?? "") Rate Chart"
        fromCurrencyLbl.text = "From Currency: " + (CurrenciesList.unitList.filter({$0.name == from}).first?.fullName ?? "")
        toCurrencyLbl.text = "To Currency: " + (CurrenciesList.unitList.filter({$0.name == unitName}).first?.fullName ?? "")
        startDateLbl.text = "Start Date: " + Date.convertDate(date: currencies?.start ?? "")
        endDateLbl.text = "End Date: " + Date.convertDate(date: currencies?.end ?? "")
        lowestLbl.text = "Lowest value: " + String(dataEntries?.0.sorted(by: {$0.y < $1.y}).first?.y ?? 0.0)
        highestLbl.text = "Highest value: " +  String(dataEntries?.0.sorted(by: {$0.y > $1.y}).first?.y ?? 0.0)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.large.rawValue),
            backBtn.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Padding.medium.rawValue),
            
            unitContentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.large.rawValue),
            unitContentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            unitContentView.widthAnchor.constraint(equalToConstant: Padding.extraLarge.rawValue * 2.5),
            unitContentView.heightAnchor.constraint(equalToConstant: Padding.extraLarge.rawValue),
            downArrowView.widthAnchor.constraint(equalTo: unitContentView.widthAnchor, multiplier: 0.27),
            
            scrollView.topAnchor.constraint(equalTo: unitContentView.bottomAnchor, constant: Padding.small.rawValue),
            scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            unitSelectBtn.topAnchor.constraint(equalTo: unitContentView.topAnchor),
            unitSelectBtn.bottomAnchor.constraint(equalTo: unitContentView.bottomAnchor),
            unitSelectBtn.leftAnchor.constraint(equalTo: unitContentView.leftAnchor),
            unitSelectBtn.rightAnchor.constraint(equalTo: unitContentView.rightAnchor),
            
            chartTypeSegment.centerYAnchor.constraint(equalTo: unitContentView.centerYAnchor),
            chartTypeSegment.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -Padding.medium.rawValue),
            chartTypeSegment.widthAnchor.constraint(equalToConstant: Padding.extraLarge.rawValue * 2),
            chartTypeSegment.heightAnchor.constraint(equalToConstant: Padding.large.rawValue * 1.4),
            
            lineChartView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Padding.medium.rawValue),
            lineChartView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Padding.small.rawValue),
            lineChartView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -Padding.small.rawValue),
            lineChartView.heightAnchor.constraint(equalToConstant: 300),
            
            barChartView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Padding.medium.rawValue),
            barChartView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Padding.small.rawValue),
            barChartView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -Padding.small.rawValue),
            barChartView.heightAnchor.constraint(equalToConstant: 300),
            
            chartDataInfoLbl.topAnchor.constraint(equalTo: lineChartView.bottomAnchor),
            chartDataInfoLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            chartDataInfoLbl.rightAnchor.constraint(equalTo: lineChartView.rightAnchor),
            
            detailContent.topAnchor.constraint(equalTo: chartDataInfoLbl.bottomAnchor, constant: Padding.large.rawValue),
            detailContent.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Padding.small.rawValue),
            detailContent.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -Padding.small.rawValue),
            detailContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            headerContent.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

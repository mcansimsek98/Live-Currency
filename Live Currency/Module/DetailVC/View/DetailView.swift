//
//  Detailswift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 26.01.2024.
//

import UIKit
import DGCharts

protocol DetailViewActionDelegate: AnyObject {
    func backBtnAction()
}

final class DetailView: UIView {
    weak var delegate: DetailViewActionDelegate?
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.back, for: .normal)
        btn.addAction(backBtnAction, for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = Theme.defaultTheme.themeFont.headlineFont.boldVersion
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
     private lazy var chartDataInfoLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = Theme.defaultTheme.themeFont.smallCaption
        lbl.textColor = Theme.defaultTheme.themeColor.textColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var chartView: LineChartView = {
        let chart = LineChartView()
        chart.animate(xAxisDuration: 0.5)
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
        chart.isUserInteractionEnabled = false
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    private lazy var backBtnAction: UIAction = UIAction { [weak self] _ in
        guard let self else { return }
        delegate?.backBtnAction()
    }
    
    init(from: String?, unitName: String?) {
        super.init(frame: .zero)
        backgroundColor = Theme.defaultTheme.themeColor.backgroundColor
        addSubViews(backBtn, titleLbl, chartView, chartDataInfoLbl)
        configureConstraint()
        
        chartDataInfoLbl.text = "\(from ?? "") to \(unitName ?? "") Rate Chart"
        titleLbl.text = unitName
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.large.rawValue),
            backBtn.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: Padding.medium.rawValue),
            
            titleLbl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.large.rawValue),
            titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            chartView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: Padding.medium.rawValue),
            chartView.centerXAnchor.constraint(equalTo: centerXAnchor),
            chartView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.27),
            chartView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.98),
            
            chartDataInfoLbl.topAnchor.constraint(equalTo: chartView.bottomAnchor),
            chartDataInfoLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            chartDataInfoLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.93),
        ])
    }
    
    func configureChart(dataEntries: [ChartDataEntry]) {
        let dataSet = LineChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = [Theme.defaultTheme.themeColor.secondaryColor]
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .linear
        
        let gradientColors = [UIColor.systemBlue.cgColor, UIColor.black.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        if let gradient = CGGradient(colorsSpace: nil, colors: gradientColors, locations: colorLocations) {
            dataSet.fill = LinearGradientFill( gradient: gradient,angle: 90.0)
            dataSet.drawFilledEnabled = true
        }
        
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
}

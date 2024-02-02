//
//  DateValueFormatter.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 3.02.2024.
//

import UIKit
import DGCharts

class DateValueFormatter: AxisValueFormatter {
    let dateFormatter = DateFormatter()

    init() {
        dateFormatter.dateFormat = "dd.MM"
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}

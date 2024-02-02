//
//  UIDate+Extension.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 3.02.2024.
//

import Foundation

extension Date {
    static func getDateString(date: Date = Date(), outputFormat: String = "dd.MM.yyyy") -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = outputFormat
        return  dateFormater.string(from: Date())
    }
    
    static func convertDate(date: String, inputFormat: String = "yyyy-MM-dd", outputFormat: String = "dd.MM.yyyy") -> String {
        let inputDateFormat = DateFormatter()
        inputDateFormat.dateFormat = inputFormat
        
        let outputDateFormat = DateFormatter()
        outputDateFormat.dateFormat = outputFormat
        outputDateFormat.timeZone = TimeZone(secondsFromGMT: 3 * 60 * 60)
        
        if let inputDate = inputDateFormat.date(from: date) {
            let gmt3Date = inputDate.addingTimeInterval(TimeInterval(TimeZone(secondsFromGMT: 3 * 60 * 60)?.secondsFromGMT(for: inputDate) ?? 0))
            return outputDateFormat.string(from: gmt3Date)
        }
        return " - "
    }
    
    static func getDateDouble(_ date: String) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: date) {
            return date.timeIntervalSince1970
        }
        return 0
    }
}

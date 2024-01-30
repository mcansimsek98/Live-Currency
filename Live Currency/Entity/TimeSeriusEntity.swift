//
//  TimeSeriusEntity.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 26.01.2024.
//

import Foundation

struct TimeSeriusEntity: Codable {
    let start, end, interval, base: String?
    let results: [String:[String: Double]]?
    let ms: Int?
}

//
//  MainEntity.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import Foundation

struct MainEntity: Codable {
    let base: String?
    let results: [String: Double]?
    let updated: String?
    let ms: Int?
}

struct MainEntityResult {
    let key: String
    let value: Double
}

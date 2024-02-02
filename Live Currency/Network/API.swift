//
//  API.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import Foundation
import Moya

let api_key = "dd089d52db-23f50e70a6-s84ge7"

enum API {
    case fetchAll(from: String)
    case getTimeSeries(from: String, to: String)
}

extension API : TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkManager.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchAll:
            return "fetch-all"
        case .getTimeSeries:
            return "time-series"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAll, .getTimeSeries:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        
        case .fetchAll(let unit):
            return .requestParameters(parameters: ["from": unit, "api_key": api_key], encoding: URLEncoding.queryString)
        case .getTimeSeries(let from, let to):
            return .requestParameters(parameters: ["from": from, "to": to, "interval": "P1D", "api_key": api_key], encoding: URLEncoding.queryString)

        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            let header: [String : String] = [
                "accept": "application/json"
            ]
            return header
        }
    }
}

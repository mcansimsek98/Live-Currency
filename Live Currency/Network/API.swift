//
//  API.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import Foundation
import Moya

let api_key = "e2cb87c0ca-3f7ed96c4e-s7nrbu"

enum API {
    case fetchAll(from: String)
}

extension API : TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkManager.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchAll:
            return "fetch-all
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAll :
            return .get
        }
    }
    
    var task: Task {
        switch self {
        
        case .fetchAll(let unit):
            return .requestParameters(parameters: ["from": unit, "api_key": api_key], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            let header: [String : String] = [:]
            return header
        }
    }
}

//
//  NetworkManager.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import Foundation
import Moya
import CombineMoya
import Combine

struct NetworkManager {
    typealias Publisher<T: Decodable> = AnyPublisher<T, Error>
    
    private init() {}
    
    static var baseURL = "https://api.fastforex.io/"
    static var shared = NetworkManager()
    private let provider = MoyaProvider<API>()
    
    func request<T: Decodable>(_ request: API) -> Publisher<T> {
        provider.requestPublisher(request)
            .tryMap { response in
                try response.map(T.self)
            }
            .mapError { error -> MoyaError in
                if let moyaError = error as? MoyaError {
                    return moyaError
                } else {
                    return MoyaError.underlying(error, nil)
                }
            }.eraseToAnyPublisher()
    }
}

extension NetworkManager {
    func fetchAllCurrencies(from: String) -> Publisher<MainEntity> {
        return NetworkManager.shared.request(.fetchAll(from: from)).eraseToAnyPublisher()
    }
}

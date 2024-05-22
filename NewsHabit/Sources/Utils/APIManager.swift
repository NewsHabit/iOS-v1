//
//  APIManager.swift
//  NewsHabit
//
//  Created by jiyeon on 3/6/24.
//

import Foundation

import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    private let serverIP = "https://newshabit.org"
    
    func fetchData<T: Decodable>(_ uri: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(serverIP + uri, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate() // Response 상태 코드가 200~299 범위 내에 있는지 확인
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}

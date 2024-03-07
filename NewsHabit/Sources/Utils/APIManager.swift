//
//  APIManager.swift
//  NewsHabit
//
//  Created by jiyeon on 3/6/24.
//

import Combine
import Foundation

import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    private var cancellables = Set<AnyCancellable>()
    private let serverIP = "http://localhost:8080/news-habit/"
//    private let serverIP = "https://3.38.7.130/news-habit/"
    
    private init() {}
    
    func fetchData<T: Decodable>(_ uri: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(serverIP + uri, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .sink(receiveCompletion: { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { response in
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
    
    func downloadImageData(from urlString: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(urlString).responseData { response in
            completion(response.result)
        }
    }
    
}

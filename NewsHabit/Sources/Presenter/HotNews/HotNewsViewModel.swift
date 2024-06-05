//
//  HotNewsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/22/24.
//

import Combine
import Foundation

import Alamofire

final class HotNewsViewModel {
    
    enum Input {
        case getHotNews
        case tapNewsCell(_ index: Int)
    }
    
    enum Output {
        case updateHotNews
        case fetchFailed
        case navigateTo(newsLink: String)
    }
    
    // MARK: - Properties
    
    var cellViewModels = [HotNewsCellViewModel]()
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .getHotNews:
                fetchNewsData()
            case let .tapNewsCell(index):
                output.send(.navigateTo(newsLink: cellViewModels[index].newsLink))
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Handle News Data
    
    private func fetchNewsData() {
        APIManager.shared.fetchData(endpoint: "/api/issues") { [weak self] (result: Result<HotNewsResponse, AFError>) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                cellViewModels = response.hotNewsResponseDtoList.map {
                    HotNewsCellViewModel(newsItem: $0)
                }
                output.send(.updateHotNews)
            case .failure(let error):
                print("HotNewsViewModel fetch data failed : \(error)")
                output.send(.fetchFailed)
            }
        }
    }
    
}

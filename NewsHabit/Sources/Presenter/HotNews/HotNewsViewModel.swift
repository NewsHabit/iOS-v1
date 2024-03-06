//
//  HotNewsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/22/24.
//

import Combine
import Foundation

import Alamofire

class HotNewsViewModel {
    
    enum Input {
        case viewWillAppear
        case tapNewsCell(_ index: Int)
    }
    
    enum Output {
        case updateHotNews
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
            case .viewWillAppear:
                self.fetchNewsData()
                self.output.send(.updateHotNews)
            case let .tapNewsCell(index):
                self.output.send(.navigateTo(newsLink: cellViewModels[index].newsLink))
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Handle News Data
    
    private func fetchNewsData() {
        APIManager.shared.fetchData("http://localhost:8080/news-habit/issue", completion: { (result: Result<HotNewsResponse, AFError>) in
            switch result {
            case let .success(response):
                self.cellViewModels = response.hotNewsResponseDtoList.map {
                    HotNewsCellViewModel(newsItem: $0)
                }
                self.output.send(.updateHotNews)
            case let .failure(error):
                print("Error: \(error)")
            }
        })
    }
}

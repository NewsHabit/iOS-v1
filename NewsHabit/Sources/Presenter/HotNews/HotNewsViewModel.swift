//
//  HotNewsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/22/24.
//

import Alamofire
import Combine
import Foundation

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
    
    func fetchNewsData() {
        AF.request("http://localhost:8080/news-habit/issue")
            .publishDecodable(type: HotNewsResponse.self)
            .value() // Publisher에서 값만 추출
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("Error: \(error)")
                }
            }, receiveValue: { [weak self] hotNewsResponse in
                guard let self = self else { return }
                self.cellViewModels = hotNewsResponse.hotNewsResponseDtoList.map {
                    HotNewsCellViewModel(newsItem: $0)
                }
                self.output.send(.updateHotNews)
            })
            .store(in: &cancellables)
    }
}

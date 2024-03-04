//
//  TodayNewsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import Alamofire
import Combine
import Foundation

class TodayNewsViewModel {
    
    enum Input {
        case getTodayNews
        case tapNewsCell(_ index: Int)
    }
    
    enum Output {
        case updateTodayNews
        case navigateTo(newsLink: String)
    }
    
    // MARK: - Properties
    
    var cellViewModels = [TodayNewsCellViewModel]()
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .getTodayNews:
                self.fetchNewsData()
//                if UserDefaultsManager.lastDate != Date().toCompactDateString() {
//                    self.fetchNewsData()
//                } else {
//                    self.cellViewModels = UserDefaultsManager.todayNews.map {
//                        TodayNewsCellViewModel($0)
//                    }
//                    self.output.send(.updateTodayNews)
//                }
            case let .tapNewsCell(index):
                self.setReadNewsItem(index)
                self.output.send(.navigateTo(newsLink: self.cellViewModels[index].newsLink))
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Handle News Data
    
    private func fetchNewsData() {
        let categories = UserDefaultsManager.categoryList.map {
            Category.allCases[$0].toAPIString()
        }
        let parameters:[String: Any] = [
            "categories": categories,
            "cnt": UserDefaultsManager.todayNewsCount.rawValue
        ]
        let customEncoding = URLEncoding(
            destination: .queryString,
            arrayEncoding: .noBrackets,
            boolEncoding: .literal
        )
        
        AF.request("http://localhost:8080/news-habit/recommendation",
                   method: .get,
                   parameters: parameters,
                   encoding: customEncoding)
            .publishDecodable(type: TodayNewsResponse.self)
            .value() // Publisher에서 값만 추출
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("Error: \(error)")
                }
            }, receiveValue: { [weak self] todayNewsResponse in
                // 성공적으로 응답 받은 경우의 처리
                guard let self = self else { return }
                self.cellViewModels = todayNewsResponse.recommendedNewsResponseDtoList.map {
                    TodayNewsCellViewModel(TodayNewsItemState(newsItem: $0))
                }
                self.initTodayNewsData()
                self.output.send(.updateTodayNews)
            })
            .store(in: &cancellables)
    }
    
    private func initTodayNewsData() {
        UserDefaultsManager.lastDate = Date().toCompactDateString()
        UserDefaultsManager.todayNews = cellViewModels.map { $0.newsItemState }
    }
    
    private func setReadNewsItem(_ index: Int) {
        guard !cellViewModels[index].isRead else { return }
        
        cellViewModels[index].isRead = true
        UserDefaultsManager.todayNews = cellViewModels.map { $0.newsItemState }
        
        let todayReadCount = cellViewModels.filter { $0.isRead }.count
        if todayReadCount == UserDefaultsManager.todayNews.count {
            UserDefaultsManager.daysAllRead += 1
        }
    }
    
}

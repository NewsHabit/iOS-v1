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
        case updateDaysAllReadCount
    }
    
    // MARK: - Properties
    
    var cellViewModels = [TodayNewsCellViewModel]()
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .getTodayNews:
                self?.fetchNewsData()
//                if UserDefaultsManager.lastDate != Date().toCompactDateString() {
//                    self?.fetchNewsData()
//                } else {
//                    self?.cellViewModels = UserDefaultsManager.todayNews.map {
//                        TodayNewsCellViewModel($0)
//                    }
//                    self?.output.send(.updateTodayNews)
//                }
            case let .tapNewsCell(index):
                self?.selectNewsItem(index)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Handle News Data
    
    private func initTodayNewsData() {
        UserDefaultsManager.lastDate = Date().toCompactDateString()
        UserDefaultsManager.todayNews = cellViewModels.map { $0.newsItemState }
    }
    
    private func fetchNewsData() {
        let categories = UserDefaultsManager.categoryList.map {
            Category.allCases[$0].toAPIString()
        }
        let parameters:[String: Any] = [
            "categories": categories,
            "cnt": categories.count
        ]
        AF.request("http://localhost:8080/news-habit/recommendation",
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString)
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
    
    private func selectNewsItem(_ index: Int) {
        if cellViewModels[index].isRead == false {
            cellViewModels[index].isRead = true
            
            var todayReadCount = 0
            for viewModel in cellViewModels {
                if viewModel.isRead {
                    todayReadCount += 1
                }
            }
            if todayReadCount == UserDefaultsManager.todayNews.count {
                UserDefaultsManager.daysAllRead = UserDefaultsManager.daysAllRead + 1
                output.send(.updateDaysAllReadCount)
            }
            // 변경된 뉴스 목록을 UserDefaults에 저장
            UserDefaultsManager.todayNews = cellViewModels.map { $0.newsItemState }
        }
    }
    
}

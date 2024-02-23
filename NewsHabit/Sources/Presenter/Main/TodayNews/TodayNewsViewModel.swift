//
//  TodayNewsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

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
    
    var newsCellViewModels = [NewsCellViewModel]()
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .getTodayNews:
                if UserDefaultsManager.lastDate != Date().toSimpleString() {
                    self?.initTodayNewsData()
                    self?.fetchNewsData()
                } else {
                    self?.getNewsData()
                }
                self?.output.send(.updateTodayNews)
            case let .tapNewsCell(index):
                self?.selectNewsItem(index)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Handle News Data
    
    private func initTodayNewsData() {
        UserDefaultsManager.todayReadCount = 0
        UserDefaultsManager.lastDate = Date().toSimpleString()
    }
    
    private func fetchNewsData() {
        let jsonData = Data(dummyData.utf8) // 더미 데이터 문자열을 Data 객체로 변환
        do {
            let decodedData = try JSONDecoder().decode(NewsResponse.self, from: jsonData)
            newsCellViewModels = decodedData.newsResponseDtoList.map {
                NewsCellViewModel(newsItem: $0, isDetailCell: true)
            }
            UserDefaultsManager.todayNews = decodedData.newsResponseDtoList
        } catch let error {
            print(error)
        }
    }
    
    private func getNewsData() {
        let newsItems = UserDefaultsManager.todayNews
        newsCellViewModels = newsItems.map {
            NewsCellViewModel(newsItem: $0, isDetailCell: true)
        }
    }
    
    private func selectNewsItem(_ index: Int) {
        if newsCellViewModels[index].isRead == false {
            newsCellViewModels[index].isRead = true
            UserDefaultsManager.todayReadCount = UserDefaultsManager.todayReadCount + 1
            if UserDefaultsManager.todayReadCount == UserDefaultsManager.todayNews.count {
                UserDefaultsManager.daysAllRead = UserDefaultsManager.daysAllRead + 1
                output.send(.updateDaysAllReadCount)
            }
            
            // 변경된 뉴스 목록을 UserDefaults에 저장
            let updatedNewsItems = newsCellViewModels.map { $0.newsItem }
            UserDefaultsManager.todayNews = updatedNewsItems
        }
    }
    
    let dummyData = """
{
    "newsResponseDtoList":
    [
        {
            "title": "전공의 55% 집단 사직…831명에 업무개시명령",
            "category": "경제",
            "naverUrl": "https://n.news.naver.com/mnews/article/422/0000645810",
            "imgLink": "https://imgnews.pstatic.net/image/422/2024/02/20/MYH20240220017100641_20240220181101941.jpg?type=w800",
            "description": "오늘 오전부터 전공의들이 출근을 중단하며 본격적인 집단 행동에 돌입했습니다. 전국에서 절반이 넘는 전공의가 사직서를 제출한 걸로 나타났는데요. 취재기자 연결해보겠습니다. 홍서현 기자, 병원 상황은 어떤가요? [기자]..."
        },
        {
            "title": "전공의 빠지자...병원일 부담 떠안은 간호사·임상병리사 동료들",
            "category": "샤회/문화",
            "naverUrl": "https://n.news.naver.com/mnews/article/008/0005001370",
            "imgLink": "https://imgnews.pstatic.net/image/008/2024/02/20/0005001370_001_20240220180301024.jpg?type=w800",
            "description": "보건의료 양대 노조로 꼽히는 전국보건의료산업노동조합(보건의료노조)와 민주노총 공공운수노조 의료연대본부(의료연대본부)가 20일 전공의의 집단 사직서 제출과 진료 중단을 한목소리로 비판했다. 보건의료노조는 이날 의사 집..."
        },
        {
            "title": "이언주 \\"한동훈, 왜 남의 당 공천에 왈가왈부하나\\"",
            "category": "정치",
            "naverUrl": "https://n.news.naver.com/mnews/article/031/0000814141",
            "imgLink": "https://imgnews.pstatic.net/image/031/2024/02/20/0000814141_001_20240220175101090.jpg?type=w800",
            "description": "이언주 전 의원이 한동훈 비상대책위원장을 향해 \\"왜 남의 당 공천에 왈가왈부하느냐\\"며 쏘아붙였다. 이 전 의원은 20일 자신의 사회관계망서비스(SNS)에 \\"민주당은 공천 때문에 시끌시끌한 반면 국힘은 조용한 편이니 ..."
        }
    ]
}
"""
}

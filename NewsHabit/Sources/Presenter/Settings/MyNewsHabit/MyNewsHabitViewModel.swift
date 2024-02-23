//
//  MyNewsHabitViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Combine
import Foundation

class MyNewsHabitViewModel {
    
    // MARK: - Input
    
    enum Input {
        case updateMyNewsHabitSettings
    }
    
    // MARK: - Output
    
    enum Output {
        case updateMyNewsHabitItems
    }
    
    // MARK: - Properties
    
    var myNewsHabitItems = [MyNewsHabitItem]()
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .updateMyNewsHabitSettings:
                self?.myNewsHabitItems.removeAll()
                self?.updateMyNewsHabitItems()
                self?.output.send(.updateMyNewsHabitItems)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Functions
    
    private func updateMyNewsHabitItems() {
        myNewsHabitItems.append(MyNewsHabitItem(
            title: "키워드",
            description: getKeywordString()
        ))
        myNewsHabitItems.append(MyNewsHabitItem(
            title: "오늘의 뉴스 개수",
            description: String(UserDefaultsManager.todayNewsCount)
        ))
    }
    
    private func getKeywordString() -> String {
        let keywordIndexArray = UserDefaultsManager.keywordList
        if keywordIndexArray.count > 1 {
            return "\(KeywordType.allCases[keywordIndexArray[0]].toString()) 외 \(keywordIndexArray.count - 1)개"
        } else {
            return KeywordType.allCases[keywordIndexArray[0]].toString()
        }
    }
    
}

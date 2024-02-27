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
            title: "카테고리",
            description: getCategoryString()
        ))
        myNewsHabitItems.append(MyNewsHabitItem(
            title: "오늘의 뉴스 개수",
            description: String(UserDefaultsManager.todayNewsCount)
        ))
    }
    
    private func getCategoryString() -> String {
        let categoryIndexArray = UserDefaultsManager.categoryList
        if categoryIndexArray.count > 1 {
            return "\(Category.allCases[categoryIndexArray[0]].toString()) 외 \(categoryIndexArray.count - 1)개"
        } else {
            return Category.allCases[categoryIndexArray[0]].toString()
        }
    }
    
}

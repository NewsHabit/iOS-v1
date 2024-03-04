//
//  MyNewsHabitViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Combine
import Foundation

class MyNewsHabitViewModel {
    
    enum Input {
        case tapMyNewsHabitCell(_ index: Int)
        case updateMyNewsHabitSettings
    }
    
    enum Output {
        case navigateTo(type: MyNewsHabitType)
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
            guard let self = self else { return }
            switch event {
            case let.tapMyNewsHabitCell(index):
                self.output.send(.navigateTo(type: myNewsHabitItems[index].type))
            case .updateMyNewsHabitSettings:
                self.myNewsHabitItems.removeAll()
                self.updateMyNewsHabitItems()
                self.output.send(.updateMyNewsHabitItems)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Functions
    
    private func updateMyNewsHabitItems() {
        myNewsHabitItems.append(MyNewsHabitItem(
<<<<<<< HEAD
            title: "카테고리",
            description: getCategoryString()
=======
            type: .keyword,
            description: getKeywordString()
>>>>>>> 94cc61ccd02e21ab174bd548d59972abc9802ace
        ))
        myNewsHabitItems.append(MyNewsHabitItem(
            type: .todayNewsCount,
            description: String(UserDefaultsManager.todayNewsCount.rawValue)
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

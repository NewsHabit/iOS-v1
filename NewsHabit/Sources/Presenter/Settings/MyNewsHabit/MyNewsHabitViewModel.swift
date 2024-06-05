//
//  MyNewsHabitViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Combine
import Foundation

final class MyNewsHabitViewModel {
    
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
                output.send(.navigateTo(type: myNewsHabitItems[index].type))
            case .updateMyNewsHabitSettings:
                updateMyNewsHabitItems()
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Functions
    
    private func updateMyNewsHabitItems() {
        myNewsHabitItems.removeAll()
        
        myNewsHabitItems.append(MyNewsHabitItem(
            type: .category,
            description: getCategoryString()
        ))
        myNewsHabitItems.append(MyNewsHabitItem(
            type: .todayNewsCount,
            description: String(UserDefaultsManager.todayNewsCount.rawValue)
        ))
        
        output.send(.updateMyNewsHabitItems)
    }
    
    private func getCategoryString() -> String {
        let categoryIndexArray = UserDefaultsManager.categoryList
        var categoryString = Category.allCases[categoryIndexArray[0]].toString()
        
        if categoryIndexArray.count > 1 {
            categoryString += " 외 \(categoryIndexArray.count - 1)개"
        }
        
        return categoryString
    }
    
}

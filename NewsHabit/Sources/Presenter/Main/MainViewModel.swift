//
//  MainViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import Foundation

final class MainViewModel {
    
    enum Input {
        case viewWillAppear
        case setMainOption(_ option: MainOption)
    }
    
    enum Output {
        case fetchTodayNews
        case updateMainOption(_ option: MainOption)
    }
    
    // MARK: - Properties
    
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .viewWillAppear:
                output.send(.fetchTodayNews)
            case let .setMainOption(option):
                output.send(.updateMainOption(option))
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
}

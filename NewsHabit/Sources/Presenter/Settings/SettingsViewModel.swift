//
//  SettingsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Combine
import UIKit

final class SettingsViewModel {
    
    enum Input {
        case viewDidLoad
        case tapSettingsCell(_ index: Int)
    }
    
    enum Output {
        case initSettingItems
        case navigateTo(type: SettingsType)
    }
    
    // MARK: - Properties
    
    var settingsItems = [
        SettingsItem(
            type: .profile,
            imageString: "person.fill"
        ),
        SettingsItem(
            type: .myNewsHabit,
            imageString: "newspaper"
        ),
        SettingsItem(
            type: .notification,
            imageString: "bell"
        ),
        SettingsItem(
            type: .theme,
            imageString: "sun.max"
        ),
        SettingsItem(
            type: .developer,
            imageString: "info.circle"
        )
    ]
    
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .viewDidLoad:
                output.send(.initSettingItems)
            case let .tapSettingsCell(index):
                output.send(.navigateTo(type: settingsItems[index].type))
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
}

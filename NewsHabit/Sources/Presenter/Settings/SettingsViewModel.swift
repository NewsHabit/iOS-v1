//
//  SettingsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import Combine
import Foundation

final class SettingsViewModel: BaseViewModel {
    
    // MARK: - Input
    
    enum Input {
        case viewDidLoad
    }
    
    // MARK: - Output
    
    enum Output {
        case updateSettings
    }
    
    // MARK: - Properties
    
    var sectionViewModels = [SettingsSectionViewModel]()
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializer
    
    init() {
        sectionViewModels.append(SettingsSectionViewModel(
            title: "나의 뉴빗",
            cellViewModels: [
                SettingsCellViewModel(
                    title: "닉네임",
                    description: "사용자",
                    settingsType: .nickname
                ),
                SettingsCellViewModel(
                    title: "키워드",
                    description: "iOS",
                    settingsType: .keyword
                ),
                SettingsCellViewModel(
                    title: "오늘의 뉴스 개수",
                    description: "3",
                    settingsType: .todayNewsCount
                )
            ]
        ))
        sectionViewModels.append(SettingsSectionViewModel(
            title: "기능 설정",
            cellViewModels: [
                SettingsCellViewModel(
                    title: "알림",
                    description: "OFF",
                    settingsType: .notification
                ),
                SettingsCellViewModel(
                    title: "테마",
                    description: "라이트 모드",
                    settingsType: .theme
                )
            ]
        ))
        sectionViewModels.append(SettingsSectionViewModel(
            title: "고객 지원",
            cellViewModels: [
                SettingsCellViewModel(title: "앱 피드백"),
                SettingsCellViewModel(title: "개발자 정보")
            ]
        ))
    }
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.output.send(.updateSettings)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Functions
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SettingsCellViewModel? {
        return sectionViewModels[indexPath.section].cellViewModels?[indexPath.row]
    }
    
}


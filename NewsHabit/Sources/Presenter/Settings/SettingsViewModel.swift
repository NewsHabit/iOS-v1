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
        case viewWillAppear
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
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewWillAppear:
                self?.sectionViewModels.removeAll()
                self?.updateSectionViewModels()
                self?.output.send(.updateSettings)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    // MARK: - Functions
    
    private func updateSectionViewModels() {
        sectionViewModels.append(SettingsSectionViewModel(
            title: "나의 뉴빗",
            cellViewModels: [
                SettingsCellViewModel(
                    title: "별명",
                    description: Settings.nickname,
                    settingsType: .nickname
                ),
                SettingsCellViewModel(
                    title: "키워드",
                    description: Settings.keyword,
                    settingsType: .keyword
                ),
                SettingsCellViewModel(
                    title: "오늘의 뉴스 개수",
                    description: String(Settings.todayNewsCount),
                    settingsType: .todayNewsCount
                )
            ]
        ))
        sectionViewModels.append(SettingsSectionViewModel(
            title: "기능 설정",
            cellViewModels: [
                SettingsCellViewModel(
                    title: "알림",
                    description: Settings.notification ? "ON" : "OFF",
                    settingsType: .notification
                ),
                SettingsCellViewModel(
                    title: "테마",
                    description: Settings.theme,
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
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SettingsCellViewModel? {
        return sectionViewModels[indexPath.section].cellViewModels?[indexPath.row]
    }
    
}

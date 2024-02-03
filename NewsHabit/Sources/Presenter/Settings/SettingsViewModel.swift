//
//  SettingsViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import Foundation

class SettingsViewModel {
    
    var sectionViewModels = [
        SettingsSectionViewModel(
            title: "나의 뉴빗",
            cellViewModels: [
                SettingsCellViewModel(
                    title: "닉네임",
                    description: "사용자"
                ),
                SettingsCellViewModel(
                    title: "키워드",
                    description: "iOS"
                ),
                SettingsCellViewModel(
                    title: "오늘의 뉴스 개수",
                    description: "3"
                )
            ]
        ),
        SettingsSectionViewModel(
            title: "기능 설정",
            cellViewModels: [
                SettingsCellViewModel(
                    title: "알림",
                    description: "OFF"
                ),
                SettingsCellViewModel(
                    title: "테마",
                    description: "라이트 모드"
                )
            ]
        ),
        SettingsSectionViewModel(
            title: "고객 지원",
            cellViewModels: [
                SettingsCellViewModel(title: "앱 피드백"),
                SettingsCellViewModel(title: "개발자 정보")
            ]
        )
    ]
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SettingsCellViewModel? {
        return sectionViewModels[indexPath.section].cellViewModels?[indexPath.row]
    }
    
}


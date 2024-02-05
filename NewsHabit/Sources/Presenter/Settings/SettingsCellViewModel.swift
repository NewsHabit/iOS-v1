//
//  SettingsCellViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import UIKit

final class SettingsCellViewModel: Identifiable {
    
    var id = UUID()
    var title: String
    var description: String?
    var descriptionColor: UIColor
    var settingsType: SettingsType?
    
    init(title: String, description: String? = nil, color: UIColor = .gray, settingsType: SettingsType? = nil) {
        self.title = title
        self.description = description
        self.descriptionColor = color
        self.settingsType = settingsType
    }
}

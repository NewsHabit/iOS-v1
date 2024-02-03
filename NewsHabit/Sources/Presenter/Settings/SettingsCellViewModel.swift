//
//  SettingsCellViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/3/24.
//

import UIKit

class SettingsCellViewModel: Identifiable {
    
    var id = UUID()
    var title: String
    var description: String?
    var descriptionColor: UIColor
    var didSelectAction: (() -> Void)?
    
    init(title: String, description: String? = nil, color: UIColor = .gray, didSelectAction: (() -> Void)? = nil) {
        self.title = title
        self.description = description
        self.descriptionColor = color
        self.didSelectAction = didSelectAction
    }
}


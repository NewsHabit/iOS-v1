//
//  NotificationItem.swift
//  NewsHabit
//
//  Created by jiyeon on 3/3/24.
//

import Foundation

enum NotificationSection: Hashable {
    case main
}

enum NotificationCell: Hashable {
    case switchCell(_ isOn: Bool)
    case timeCell(_ time: String)
}

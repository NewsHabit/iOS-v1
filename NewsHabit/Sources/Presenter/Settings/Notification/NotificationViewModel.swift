//
//  NotificationViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import Combine
import Foundation

class NotificationViewModel {
    
    @Published var isNotificationOn = UserDefaultsManager.isNotificationOn
    @Published var nofiticationTime = UserDefaultsManager.notificationTime
    
}

//
//  NotificationViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import Combine
import Foundation
import UserNotifications
import UIKit

class NotificationViewModel {
    
    enum Input {
        case setNotification(_ isOn: Bool)
        case setNotificationTime(_ date: Date)
    }
    
    enum Output {
        case permissionDenied
        case updateNotification
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
            case let .setNotification(isOn):
                self.handleNotification(isOn)
            case let .setNotificationTime(date):
                self.handleNotificationTime(date)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func handleNotification(_ isOn: Bool) {
        UserDefaultsManager.isNotificationOn = isOn
        NotificationCenterManager.shared.removeAllPendingNotificationRequests()
        
        if !isOn {
            self.output.send(.updateNotification)
            return
        }
        
        NotificationCenterManager.shared.checkNotificationAuthorization { [weak self] isAuthorized in
            guard let self = self else { return }
            
            if isAuthorized { // 알림 권한 허용
                if let notificationTime = UserDefaultsManager.notificationTime.toTimeAsDate() {
                    NotificationCenterManager.shared.addNotification(for: notificationTime)
                    self.output.send(.updateNotification)
                }
            } else { // 알림 권한 거부
                UserDefaultsManager.isNotificationOn = false
                self.output.send(.permissionDenied)
            }
        }
    }
    
    private func handleNotificationTime(_ date: Date) {
        UserDefaultsManager.notificationTime = date.toSimpleTimeString()
        NotificationCenterManager.shared.addNotification(for: date)
        output.send(.updateNotification)
    }
    
}

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
        case updateNotification
        case showAlert
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
                UserDefaultsManager.isNotificationOn = isOn
                NotificationCenterManager.shared.removeAllPendingNotificationRequests()
                if isOn {
                    NotificationCenterManager.shared.requestAuthorization { granted, error in
                        if granted {
                            if let notificationTime = UserDefaultsManager.notificationTime.toTimeAsDate() {
                                NotificationCenterManager.shared.addNotification(for: notificationTime)
                            }
                        } else {
                            UserDefaultsManager.isNotificationOn = false
                            self.output.send(.showAlert)
                        }
                        // 권한 요청 결과와 상관없이 UI 업데이트
                        self.output.send(.updateNotification)
                    }
                } else {
                    self.output.send(.updateNotification)
                }
            case let .setNotificationTime(date):
                UserDefaultsManager.notificationTime = date.toSimpleTimeString()
                NotificationCenterManager.shared.addNotification(for: date)
                output.send(.updateNotification)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
}

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

final class NotificationViewModel {
    
    enum Input {
        case setNotificationStatus(_ isOn: Bool)
        case setNotificationTime(_ date: Date)
        case updateNotificationStatus
    }
    
    enum Output {
        case permissionDenied
        case updateNotificationStatus(_ isOn: Bool)
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
            case let .setNotificationStatus(isOn):
                handleNotificationStatus(isOn)
            case let .setNotificationTime(date):
                handleNotificationTime(date)
            case .updateNotificationStatus:
                output.send(.updateNotificationStatus(UserDefaultsManager.isNotificationOn))
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func handleNotificationStatus(_ isOn: Bool) {
        // UserDefaults 값 업데이트
        UserDefaultsManager.isNotificationOn = isOn
        
        if isOn {
            enableNotification()
        } else {
            disableNotification()
        }
    }

    private func enableNotification() {
        UserNotificationManager.shared.checkNotificationAuthorization { [weak self] isAuthorized in
            guard let self = self else { return }
            if isAuthorized {
                scheduleNotification()
            } else {
                handleAuthorizationDenied()
            }
        }
    }
    
    private func scheduleNotification() {
        if let notificationTime = UserDefaultsManager.notificationTime.toTimeAsDate() {
            UserNotificationManager.shared.scheduleNotification(for: notificationTime)
            output.send(.updateNotificationStatus(true))
        }
    }

    private func handleAuthorizationDenied() {
        UserDefaultsManager.isNotificationOn = false
        UserNotificationManager.shared.disableNotification()
        output.send(.permissionDenied)
    }

    private func disableNotification() {
        UserNotificationManager.shared.disableNotification()
        output.send(.updateNotificationStatus(false))
    }
    
    private func handleNotificationTime(_ date: Date) {
        UserDefaultsManager.notificationTime = date.toSimpleTimeString()
        UserNotificationManager.shared.scheduleNotification(for: date)
        output.send(.updateNotificationStatus(true))
    }
    
}

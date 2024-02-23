//
//  NotificationViewModel.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import Combine
import Foundation
import UserNotifications

class NotificationViewModel {
    
    enum Input {
        case setNotification(_ isOn: Bool)
        case setNotificationTime(_ date: Date)
    }
    
    enum Output {
        case updateNotificationTime
        case updateNotification
    }
    
    // MARK: - Properties
    
    let input = PassthroughSubject<Input, Never>()
    private let output = PassthroughSubject<Output, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Input -> Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case let .setNotification(isOn):
                UserDefaultsManager.isNotificationOn = isOn
                if !isOn {
                    self?.removeNotification()
                }
                self?.output.send(.updateNotification)
            case let .setNotificationTime(date):
                UserDefaultsManager.notificationTime = date.toTimeString()
                self?.addNotification(date)
                self?.output.send(.updateNotificationTime)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func addNotification(_ date: Date) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                notificationCenter.removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
                content.title = "뉴빗"
                content.body = "뉴스도 습관처럼 📰\n오늘의 뉴스가 도착했어요"
                content.sound = .default
                
                let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                notificationCenter.add(request) { error in
                    if let error = error {
                        print("알림 추가 실패: \(error.localizedDescription)")
                    }
                }
            } else if let error = error {
                print("권한 요청 실패: \(error.localizedDescription)")
            }
        }
    }
    
    private func removeNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
}

//
//  NotificationCenterManager.swift
//  NewsHabit
//
//  Created by jiyeon on 3/3/24.
//

import Foundation
import UserNotifications

class NotificationCenterManager {
    
    static let shared = NotificationCenterManager()
    
    private init() {}
    
    func checkNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional: // 권한이 있을 경우
                    completion(true)
                case .denied, .notDetermined, .ephemeral: // 권한이 없거나 아직 결정되지 않았을 경우
                    completion(false)
                @unknown default: // 알 수 없는 새로운 상태일 경우
                    completion(false)
                }
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                completion(granted, error)
            }
        }
    }
    
    func addNotification(for date: Date, with identifier: String = UUID().uuidString) {
        let content = UNMutableNotificationContent()
        content.title = "뉴빗"
        content.body = "뉴스도 습관처럼 📰\n오늘의 뉴스가 도착했어요"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 추가 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func removeAllPendingNotificationRequests() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

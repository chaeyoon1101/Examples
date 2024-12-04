//
//  NotificationManager.swift
//  LocalNotification
//
//  Created by 임채윤 on 12/2/24.
//

import Foundation
import UserNotifications
import CoreLocation

final class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if granted {
                print("알림 권한을 허용했습니다")
            } else {
                print("알림 권한을 거부했습니다")
            }
            
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void ) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            completion(settings.authorizationStatus)
        }
    }
    
    func scheduleWithCalendar() { // 특정 시간에 알림 받기
        let content = UNMutableNotificationContent()
        content.title = "즐거운 토요일"
        content.body = "행복한 주말 되세요!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        
        // 일요일부터 1, 월요일은 2, 화요일은 3 ~~~ 토요일은 6
        dateComponents.weekday = 6
        dateComponents.hour = 9
        dateComponents.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, content: content, trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("알림 추가 완료")
            }
        }
    }
    
    func scheduleWithTimeInterval() { // 지금으로 부터 특정 시간 뒤 알림 받기
        let content = UNMutableNotificationContent()
        
        content.title = "안녕하세요"
        content.subtitle = "Foreground에서도 알림은 받으셔야죠"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1, repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, content: content, trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("알림 추가 완료")
            }
        }
    }
    
    
    func scheduleWithLocation() { // 특정 위치에 도달하거나 떠날 때 알림 받기
        let content = UNMutableNotificationContent()
        content.title = "위치 알림"
        content.subtitle = "목적지까지 얼마 남지 않았어요"
        content.sound = .default
        
        let center = CLLocationCoordinate2D(latitude: 35.222710, longitude: 128.582206)
        let region = CLCircularRegion(
            center: center,
            radius: 100, // 반경 100미터
            identifier: UUID().uuidString
        )
        region.notifyOnEntry = true // 진입 시 알림
        region.notifyOnExit = false // 떠날 때 알림
        
        let trigger = UNLocationNotificationTrigger(
            region: region, repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("알림 추가 완료")
            }
        }
    }
    
    func removePendingNotifications(identifiers: [String]) { // 보내지지 않은 알림 삭제하기
        let center = UNUserNotificationCenter.current()
        
        // 보내지지 않은 모든 알림 삭제
        center.removeAllPendingNotificationRequests()
        
        // 보내지지 않은 알림 중 선택하여 삭제
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    func removeDeliveredNotifications(identifiers: [String]) { // 이미 전송된 알림 삭제하기
        let center = UNUserNotificationCenter.current()
        
        // 전송된 알림 모두 삭제
        center.removeAllDeliveredNotifications()
        
        // 전송된 알림 중 선택하여 삭제
        center.removeDeliveredNotifications(withIdentifiers: identifiers)
    }
}

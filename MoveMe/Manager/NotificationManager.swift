//
//  NotificationManager.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    static let instance = NotificationManager()
    
    func requestAuth() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (_, error) in
            if let error = error {
                print("ERROR: \(error)")
            }
        }
    }
    
    func scheduleNotification(currentDate: Date) {
        removeAllNotifications()
        setReminder(currentDate)
        
        let content = UNMutableNotificationContent()
        content.title = "움직일 시간이에요!"
        content.body = "오늘도 힘내세요 🔥"
        
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: currentDate)
        dateComponents.minute = Calendar.current.component(.minute, from: currentDate)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: Constant.notification,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // Send a warning when the user terminated the app.
    func sendTerminatedWarning() {
        let content = UNMutableNotificationContent()
        content.title = "뭅미를 종료하셨군요 🥺"
        content.body = "앱을 종료하면 알람이 울리지 않을 수 있어요."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: Constant.terminationWarning,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendRepitition() {
        let content = UNMutableNotificationContent()
        content.title = "뭅미 알림"
        content.subtitle = "앱에서 반복 알림을 해제할 수 있어요."
        content.body = "할 수 있다! 🔥"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "messageRingtone.mp3"))
        
        for i in 1...30 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(i * 2), repeats: false)
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
        
        for i in 0...30 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(60 + (i * 2)), repeats: true)
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func stopRepitition() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

private extension NotificationManager {
    // Send reminder to the user 30 mins earlier.
    func setReminder(_ currentDate: Date) {
        let timeOfRemind = currentDate.addingTimeInterval(-30 * 60)
        
        let content = UNMutableNotificationContent()
        content.title = "출발 30분 전이에요 💙"
        content.body = "여유롭게 출발해보는 것은 어떨까요?"
        
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: timeOfRemind)
        dateComponents.minute = Calendar.current.component(.minute, from: timeOfRemind)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: Constant.reminder,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}

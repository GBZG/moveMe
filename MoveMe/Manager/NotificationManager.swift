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
    
    // Send TimeToMove notification regardless of year, month, day
    // Just need to check hour and minute when it is required.
    func setStartNotification(currentDate: Date) {
        removeAllNotifications()
        setReminder(currentDate)
        
        // 출발할 시간이에요
        let content = UNMutableNotificationContent()
        content.title = "NotificationManagerAlarmTime".localized()
        content.body = "NotificationManagerAlarmDescription".localized()
        
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
        
    // 반복 알림
    func scheduleRepitition(_ alarmDate: Date) {
        // TimeInterval Between AlarmDate and Now
        var startingTime = alarmDate.timeIntervalSinceNow
        if startingTime <= 0 {
            startingTime = alarmDate.tomorrow.alarmTimeSetting.timeIntervalSinceNow
        }
        let content = UNMutableNotificationContent()
        content.title = "NotificationManagerRepititionTitle".localized()
        content.body = "NotificationManagerRepititionDescription".localized()
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "messageRingtone.mp3"))
        
        for i in 1...30 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: startingTime + TimeInterval(i * 2), repeats: false)
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
        
        for i in 0...30 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: startingTime + TimeInterval(60 + (i * 2)), repeats: true)
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func setImmediateRepitition() {
        removeAllNotifications()
        let content = UNMutableNotificationContent()
        content.title = "NotificationManagerRepititionTitle".localized()
        content.body = "NotificationManagerRepititionDescription".localized()
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
    
    func getDeliveredNotifications() -> Int {
        var quantity = 0
        print("⭐️⭐️⭐️ Before: \(quantity)")
        UNUserNotificationCenter.current().getDeliveredNotifications { notis in
            quantity = notis.count
        }
        
        print("⭐️⭐️⭐️ After: \(quantity)")
        return quantity
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
        content.title = "NotificationManagerRepititionReminderTitle".localized()
        content.body = "NotificationManagerRepititionReminderDescription".localized()
        
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
    
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

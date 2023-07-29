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
    
    // Send a warning when the user terminated the app.
    func sendTerminatedWarning() {
        let content = UNMutableNotificationContent()
        content.title = "NotificationManagerTerminationTitle".localized()
        content.body = "NotificationManagerTerminationDescription".localized()
        
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
}

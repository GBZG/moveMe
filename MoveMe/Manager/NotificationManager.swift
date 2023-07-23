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
        content.title = "종료하지 마세요!!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: Constant.terminationWarning,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendResetNotification() {
        print("Reset Noti Func worked")
        let content = UNMutableNotificationContent()
        content.title = "알람이 준비되었어요!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}

private extension NotificationManager {
    // Remove all notification data.
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    // Send reminder to the user 30 mins earlier.
    func setReminder(_ currentDate: Date) {
        let timeOfRemind = currentDate.addingTimeInterval(-30 * 60)
        
        let content = UNMutableNotificationContent()
        content.title = "도착 30분 전!!"
        
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

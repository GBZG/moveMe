//
//  WaitingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

final class WaitingViewModel: ObservableObject {
    func onAppear() { }
    
    func didTapAlarmChangeButton(_ currentDate: Date) {
        changeAlarm(currentDate)
        changeNotificationSchedule(currentDate)
    }
}

extension WaitingViewModel {    
    func changeAlarm(_ currentDate: Date) {
        let hour = Calendar.current.component(.hour, from: currentDate)
        let minute = Calendar.current.component(.minute, from: currentDate)
        
        // Seve New Alarm Data
        UserDefaults.standard.set(hour, forKey: Constant.scheduledHour)
        UserDefaults.standard.set(minute, forKey: Constant.scheduledMinute)
                
        if (Date() >= currentDate) {
            // When the user select past time. Then set tomorrow alarm
            AlarmManager.instance.setTimer(currentDate.tomorrow)
        } else {
            AlarmManager.instance.setTimer(currentDate)
        }
    }
    
    func changeNotificationSchedule(_ currentDate: Date) {
        NotificationManager.instance.scheduleNotification(currentDate: currentDate)
    }
}

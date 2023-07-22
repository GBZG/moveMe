//
//  ChangeViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

final class ChangeViewModel: ObservableObject {
    @Published var scheduledHour = String(
        format: "%02d",
        UserDefaults.standard.integer(forKey: Constant.scheduledHour)
    )
    @Published var scheduledMinute = String(
        format: "%02d",
        UserDefaults.standard.integer(forKey: Constant.scheduledMinute)
    )
    
    func didTapAlarmChangeButton(_ currentDate: Date) {
        changeAlarm(currentDate)
        changeSchedule(currentDate)
    }
}

extension ChangeViewModel {
    func changeAlarm(_ currentDate: Date) {
        let hour = Calendar.current.component(.hour, from: currentDate)
        let minute = Calendar.current.component(.minute, from: currentDate)
        
        // Change Current View
        UserDefaults.standard.set(Constant.changed, forKey: Constant.alarmStatus)

        // Seve New Alarm Data
        UserDefaults.standard.set(hour, forKey: Constant.scheduledHour)
        UserDefaults.standard.set(minute, forKey: Constant.scheduledMinute)
        
        AlarmManager.instance.changeTimer(currentDate)
    }
    
    func changeSchedule(_ currentDate: Date) {
        NotificationManager.instance.scheduleNotification(currentDate: currentDate)
    }
}

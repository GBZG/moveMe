//
//  AlarmViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

final class AlarmViewModel: ObservableObject {
    func onAppear() {

    }    
}

private extension AlarmViewModel {
    func restartAlarm() {
        AlarmManager.instance.restartRecentAlarm()
    }
    
    func checkAlarmStatus() {
        let amount = NotificationManager.instance.getDeliveredNotifications()
        print(amount)
        if (amount > 0) { activateAlarm() }
    }
    
    func activateAlarm() {
        UserDefaults.standard.set(Constant.active, forKey: Constant.alarmStatus)
        HapticManager.instance.vibration()
        NotificationManager.instance.setImmediateRepitition()
    }
 }

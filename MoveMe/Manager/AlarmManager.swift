//
//  AlarmManager.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/22.
//

import Foundation

final class AlarmManager: ObservableObject {
    static let instance = AlarmManager()
    var timer: Timer?
    
    func setTimer(_ currentDate: Date) {
        runTimer(currentDate.alarmTimeSetting)
    }
        
    func completeAlarm() {
        UserDefaults.standard.set(Constant.waiting, forKey: Constant.alarmStatus)
        setTomorrowAlarm()
    }
    
    func restartRecentAlarm() {
        guard let recentAlarmDate = UserDefaults.standard.object(forKey: Constant.nextAlarm) as? Date
        else { return }
        
        runTimer(recentAlarmDate.alarmTimeSetting)
    }
}

private extension AlarmManager {
    func setTomorrowAlarm() {
        let tomorrowAlarmTime = Date().tomorrow.alarmTimeSetting
        
        runTimer(tomorrowAlarmTime)
        NotificationManager.instance.scheduleNotification(currentDate: tomorrowAlarmTime)
    }
    
    func runTimer(_ date: Date) {
        stopPreviousAlarm()
        guard timer == nil else { return }
        
        setNotification(date)
        timer = Timer(
            fireAt: date,
            interval: 0,
            target: self,
            selector: #selector(runAlarm),
            userInfo: nil,
            repeats: false
        )
        
        RunLoop.main.add(timer!, forMode: .common)
        UserDefaults.standard.set(date, forKey: Constant.nextAlarm)
    }

    @objc func runAlarm() {
        UserDefaults.standard.set(Constant.active, forKey: Constant.alarmStatus)
        NotificationManager.instance.sendRepitition()
    }
    
    func setNotification(_ date: Date) {
        NotificationManager.instance.scheduleNotification(currentDate: date)
    }
        
    func stopPreviousAlarm() {
        timer?.invalidate()
        timer = nil
    }
}

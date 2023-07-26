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
        stopPreviousAlarm()
        guard timer == nil else { return }
        runTimer(currentDate.alarmTimeSetting)
    }
        
    func completeAlarm() {
        UserDefaults.standard.set(Constant.waiting, forKey: Constant.alarmStatus)
        setTomorrowAlarm()
    }
}

private extension AlarmManager {
    func setTomorrowAlarm() {
        stopPreviousAlarm()
        
        guard timer == nil else { return }
        
        let tomorrowAlarmTime = Date().tomorrow.alarmTimeSetting
        
        runTimer(tomorrowAlarmTime)
        NotificationManager.instance.scheduleNotification(currentDate: tomorrowAlarmTime)
    }
    
    func runTimer(_ date: Date) {
        guard timer == nil else { return }
        
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
        SoundManager.instance.stopBackgroundMusic()
        SoundManager.instance.playAlarmMusic()
        HapticManager.instance.vibration()
    }
    
    @objc func runStatusReset() {
        UserDefaults.standard.set(Constant.waiting, forKey: Constant.alarmStatus)
        NotificationManager.instance.sendResetNotification()
    }
    
    func stopPreviousAlarm() {
        timer?.invalidate()
        timer = nil
    }
}

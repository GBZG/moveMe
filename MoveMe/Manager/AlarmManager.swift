//
//  AlarmManager.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/22.
//

import Foundation

enum AlarmStatus: String {
    case active = "active"
    case waiting = "waiting"
    case changed = "changed"
    case completed = "completed"
    case discarded = "discarded"
}

final class AlarmManager: ObservableObject {
    static let instance = AlarmManager()
    var timer: Timer?
    
    func setTimer(_ currentDate: Date) {
        runTimer(currentDate.originalAlarmTimeSetting)
    }
    
    func changeTimer(_ currentDate: Date) {
        guard timer == nil else { return }
        stopPreviousAlarm()
        runTimer(currentDate.changedAlarmTimeSetting)
    }
        
    func completeAlarm() {
        UserDefaults.standard.set(Constant.completed, forKey: Constant.alarmStatus)
        setTomorrowAlarm()
        resetOnMidNight()
    }
}

private extension AlarmManager {
    func setTomorrowAlarm() {
        guard timer == nil else { return }
        stopPreviousAlarm()
        runTimer(Date().originalAlarmForTomorrow)
        NotificationManager.instance.scheduleNotification(currentDate: Date().originalAlarmForTomorrow)
    }
    
    func resetOnMidNight() {
        let timer = Timer(
            fireAt: Date().endOfDay,
            interval: 0,
            target: self,
            selector: #selector(runStatusReset),
            userInfo: nil,
            repeats: false
        )
        RunLoop.main.add(timer, forMode: .common)
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

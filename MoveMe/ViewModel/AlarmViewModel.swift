//
//  AlarmViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

final class AlarmViewModel: ObservableObject {
    @Published var nextAlarm = Date()
    
    func onAppear(_ alarmStatus: String) {
        calculateNextAlarm(alarmStatus)
    }
    
    func onDisappear() {
        sendTerminationWarning()
    }
}

private extension AlarmViewModel {
    func sendTerminationWarning() {
        NotificationManager.instance.sendTerminatedWarning()
    }
    
    func calculateNextAlarm(_ alarmStatus: String) {
        if (alarmStatus == Constant.completed) {
            nextAlarm = Date().originalAlarmForTomorrow
        } else if (alarmStatus == Constant.changed) {
            nextAlarm = Date().changedAlarmTimeSetting
        } else {
            nextAlarm = Date().originalAlarmTimeSetting
        }
    }
}

//
//  AlarmViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

final class AlarmViewModel: ObservableObject {
    func onAppear() {
        restartAlarm()
    }
    
    func onDisappear() {
        sendTerminationWarning()
    }
}

private extension AlarmViewModel {
    func restartAlarm() {
        AlarmManager.instance.restartRecentAlarm()
    }
    
    func sendTerminationWarning() {
        NotificationManager.instance.sendTerminatedWarning()
        NotificationManager.instance.stopRepitition()
    }
}

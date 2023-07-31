//
//  CompletionViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import CoreData
import Foundation

final class CompletionViewModel: ObservableObject {
    func onAppear() {
        createSuccessHistory()
    }
    
    func onDisappear() {
        changeAlarmStatus()
    }
}

private extension CompletionViewModel {
    func createSuccessHistory() {
        guard let alarmData = CoreDataManager.instance.getAllAlarms().first else { return }
        let tomorrowAlarmTime = Date().tomorrow.alarmTimeSetting
        let hour = Int16(Calendar.current.component(.hour, from: tomorrowAlarmTime))
        let minute = Int16(Calendar.current.component(.minute, from: tomorrowAlarmTime))

        CoreDataManager.instance.createHistory(date: alarmData.date ?? Date(), result: true)
        CoreDataManager.instance.editAlarm(
            alarm: alarmData,
            date: tomorrowAlarmTime,
            hour: hour,
            minute: minute
        )
    }
    
    func changeAlarmStatus() {
        UserDefaults.standard.set(Constant.waiting, forKey: Constant.alarmStatus)
    }
}

//
//  WaitingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

final class WaitingViewModel: ObservableObject {
    @Published var originalHour = String(
        format: "%02d",
        UserDefaults.standard.integer(forKey: Constant.originalHour)
    )
    @Published var originalMinute = String(
        format: "%02d",
        UserDefaults.standard.integer(forKey: Constant.originalMinute)
    )
    @Published var scheduledHour = String(
        format: "%02d",
        UserDefaults.standard.integer(forKey: Constant.scheduledHour)
    )
    @Published var scheduledMinute = String(
        format: "%02d",
        UserDefaults.standard.integer(forKey: Constant.scheduledMinute)
    )
    @Published var nextAlarm = Date()
    
    func onAppear() {
        calculateTimeLeft()
    }
}

private extension WaitingViewModel {
    func calculateTimeLeft() {
        nextAlarm = Date().changedAlarmTimeSetting
    }
}

//
//  AlarmViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

final class AlarmViewModel: ObservableObject {
    @Published var alarmData: AlarmEntity?
    
    func onAppear() {
        loadAlarmData()
    }
}

private extension AlarmViewModel {
    func loadAlarmData() {
        guard let data = CoreDataManager.instance.getAllAlarms().first else { return }
        alarmData = data
    }    
}

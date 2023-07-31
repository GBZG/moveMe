//
//  ContentViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/22.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var alarmData: AlarmEntity?
    @Published var locationManager = LocationManager()
    
}

private extension ContentViewModel {
    func loadAlarmData() {
        guard let data = CoreDataManager.instance.getAllAlarms().first else { return }
        alarmData = data
    }
}

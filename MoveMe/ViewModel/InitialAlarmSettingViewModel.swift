//
//  InitialAlarmSettingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import SwiftUI
import MapKit

final class InitialAlarmSettingViewModel: ObservableObject {
    func onAppear(_ manager: LocationManager) -> MKCoordinateRegion {
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: manager.coordinate?.latitude ?? 0 ,
                longitude: manager.coordinate?.longitude ?? 0),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        
        return region
    }
    
    func didTapCreateAlarmButton(currentDate: Date, latitude: Double?, longitude: Double?) {
        setInitialAlarm(currentDate, latitude, longitude)
    }
}

private extension InitialAlarmSettingViewModel {
    func setInitialAlarm(_ currentDate: Date, _ latitude: Double?, _ longitude: Double?) {
        let hour = Calendar.current.component(.hour, from: currentDate)
        let minute = Calendar.current.component(.minute, from: currentDate)
        
        // Change the Current View from Starting to Alarm
        UserDefaults.standard.set(true, forKey: Constant.isFirstLaunch)
                
        if (Date() >= currentDate) {
            // When the user select past time. Then set tomorrow alarm
            CoreDataManager.instance.createAlarm(
                date: currentDate.tomorrow,
                hour: Int16(hour),
                minute: Int16(minute),
                latitude: latitude ?? 0,
                longitude: longitude ?? 0
            )
            AlarmManager.instance.setTimer(currentDate.tomorrow)
        } else {
            CoreDataManager.instance.createAlarm(
                date: currentDate,
                hour: Int16(hour),
                minute: Int16(minute),
                latitude: latitude ?? 0,
                longitude: longitude ?? 0
            )
            AlarmManager.instance.setTimer(currentDate)
        }
    }
}

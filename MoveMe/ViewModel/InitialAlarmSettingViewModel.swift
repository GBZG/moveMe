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
        setAlarm(currentDate, latitude, longitude)
        setNotificationSchedule(currentDate)
    }
}

private extension InitialAlarmSettingViewModel {
    func setAlarm(_ currentDate: Date, _ latitude: Double?, _ longitude: Double?) {
        let hour = Calendar.current.component(.hour, from: currentDate)
        let minute = Calendar.current.component(.minute, from: currentDate)
        
        // Change the Current View from Starting to Alarm
        UserDefaults.standard.set(true, forKey: Constant.isAlarmSet)

        // Seve Alarm Data
        UserDefaults.standard.set(hour, forKey: Constant.scheduledHour)
        UserDefaults.standard.set(minute, forKey: Constant.scheduledMinute)
        
        // Save the First Original Alarm Setting
        UserDefaults.standard.set(hour, forKey: Constant.originalHour)
        UserDefaults.standard.set(minute, forKey: Constant.originalMinute)
        
        // Save Coordinate Data of the Destination
        UserDefaults.standard.set(latitude, forKey: Constant.latitude)
        UserDefaults.standard.set(longitude, forKey: Constant.longitude)
        
        if (Date() >= currentDate) {
            // When the user select past time. Then set tomorrow alarm
            AlarmManager.instance.setTheFirstAlarmonTomorrow()
        } else {
            AlarmManager.instance.setTimer(currentDate)
        }
    }
    
    func setNotificationSchedule(_ currentDate: Date) {
        NotificationManager.instance.scheduleNotification(currentDate: currentDate)
    }
}

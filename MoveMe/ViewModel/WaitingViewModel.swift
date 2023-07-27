//
//  WaitingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation
import MapKit

final class WaitingViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    @Published var mapLocations: [MapLocation] = []
    
    func onAppear() {
        let latitude = UserDefaults.standard.double(forKey: Constant.latitude) as Double
        let longitude = UserDefaults.standard.double(forKey: Constant.longitude) as Double
        
        mapLocations = [
            MapLocation(
                name: "목적지",
                latitude: latitude,
                longitude: longitude
            )
        ]
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
    
    func didTapAlarmChangeButton(_ currentDate: Date) {
        changeAlarm(currentDate)
        changeNotificationSchedule(currentDate)
    }
}

extension WaitingViewModel {    
    func changeAlarm(_ currentDate: Date) {
        let hour = Calendar.current.component(.hour, from: currentDate)
        let minute = Calendar.current.component(.minute, from: currentDate)
        
        // Seve New Alarm Data
        UserDefaults.standard.set(hour, forKey: Constant.scheduledHour)
        UserDefaults.standard.set(minute, forKey: Constant.scheduledMinute)
                
        if (Date() >= currentDate) {
            // When the user select past time. Then set tomorrow alarm
            AlarmManager.instance.setTimer(currentDate.tomorrow)
        } else {
            AlarmManager.instance.setTimer(currentDate)
        }
    }
    
    func changeNotificationSchedule(_ currentDate: Date) {
        NotificationManager.instance.scheduleNotification(currentDate: currentDate)
    }
}

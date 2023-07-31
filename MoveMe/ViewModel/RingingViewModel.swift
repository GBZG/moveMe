//
//  RingingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import Foundation
import MapKit

final class RingingViewModel: ObservableObject {
    @Published var alarmData: AlarmEntity?
    @Published var distance: Int? = nil
    @Published var isAlertActive = false
    @Published var isAlarmCompleted = false
    @Published var savedCoordiates: CLLocation? = nil
    
    func onAppear(_ manager: LocationManager) -> MKCoordinateRegion {
        loadAlarmData()
        runAlarm()
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: manager.coordinate?.latitude ?? 0 ,
                longitude: manager.coordinate?.longitude ?? 0),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        
        return region
    }
    
    func didTapCompleteButton(currentLocation: CLLocation) {
        let distance = getDistanceInMeters(currentLocation)
        if (distance <= 12) {
            isAlertActive = false
            completeAlarm()
        } else {
            isAlertActive = true
        }
    }
    
    func tapAlertCloseButton() { isAlertActive = false }
    
    func didTapStopRepitition() {
        stopRepitition()
    }
    
    func didTapDelayButton() {
        delayAlarmFiveMinutes()
    }
}

private extension RingingViewModel {
    func loadAlarmData() {
        guard let data = CoreDataManager.instance.getAllAlarms().first else { return }
        alarmData = data
    }
    
    func runAlarm() {
        AlarmManager.instance.runAlarmImmediately()
    }
    
    func delayAlarmFiveMinutes() {
        guard let alarmData = alarmData else { return }
        
        var components = DateComponents()
        components.minute = 5
        let date = Calendar.current.date(byAdding: components, to: Date())!
        let hour = Int16(Calendar.current.component(.hour, from: date))
        let minute = Int16(Calendar.current.component(.minute, from: date))
        
        CoreDataManager.instance.editAlarm(
            alarm: alarmData,
            date: date,
            hour: hour,
            minute: minute
        )
        AlarmManager.instance.setTimer(date)
        UserDefaults.standard.set(Constant.waiting, forKey: Constant.alarmStatus)
    }
    
    // Calculate distance between original coordinate and the user's currnet location in meters.
    func getDistanceInMeters(_ currentLocation: CLLocation) -> Double {
        guard let alarmData = alarmData else { return 0 }
        let latitude = alarmData.latitude
        let longitude = alarmData.longitude
        let coordinate = CLLocation(latitude: latitude, longitude: longitude)
        savedCoordiates = coordinate
        
        let distanceInMeters = currentLocation.distance(from: coordinate)
        self.distance = Int(distanceInMeters)
        return distanceInMeters
    }
    
    func completeAlarm() {
        AlarmManager.instance.completeAlarm()
        SoundManager.instance.stopBackgroundMusic()
        SoundManager.instance.playSilentMusic()
        isAlarmCompleted = true
    }
    
    func stopRepitition() {
        NotificationManager.instance.stopRepitition()
    }
}

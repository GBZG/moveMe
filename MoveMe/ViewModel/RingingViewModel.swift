//
//  RingingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import Foundation
import MapKit

final class RingingViewModel: ObservableObject {
    @Published var distance: Int? = nil
    @Published var isAlertActive = false
    @Published var savedCoordiates: CLLocation? = nil
    @Published var scheduledHour = UserDefaults.standard.integer(forKey: Constant.scheduledHour)
    @Published var scheduledMinute = UserDefaults.standard.integer(forKey: Constant.scheduledMinute)

    func onAppear(_ manager: LocationManager) -> MKCoordinateRegion {
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
        }
        
        isAlertActive = true
    }
    
    func tapAlertCloseButton() {
        isAlertActive = false
    }
    
}

private extension RingingViewModel {
    // Calculate distance between original coordinate and the user's currnet location in meters.
    func getDistanceInMeters(_ currentLocation: CLLocation) -> Double {
        let savedLatitude = UserDefaults.standard.double(forKey: Constant.latitude)
        let savedLongitude = UserDefaults.standard.double(forKey: Constant.longitude)
        let coordinate = CLLocation(latitude: savedLatitude, longitude: savedLongitude)
        savedCoordiates = coordinate
        
        let distanceInMeters = currentLocation.distance(from: coordinate)
        self.distance = Int(distanceInMeters)
        return distanceInMeters
    }
    
    func completeAlarm() {
        SoundManager.instance.stopBackgroundMusic()
        SoundManager.instance.playSilentMusic()
        AlarmManager.instance.completeAlarm()
    }
    
//    func discardAlarm() {
//        SoundManager.instance.stopBackgroundMusic()
//        SoundManager.instance.playSilentMusic()
//        AlarmManager.instance.discardAlarm()
//    }
}

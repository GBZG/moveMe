//
//  WaitingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation
import Combine
import MapKit

final class WaitingViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    @Published var mapLocations: [MapLocation] = []
    @Published var count = 0
    private var cancellables = Set<AnyCancellable>()

    init() {
        setUpTimer()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    func onAppear() { loadMapData() }
    
    func onChange() { checkAlarmStatus() }
    
    func didTapAlarmChangeButton(_ currentDate: Date) {
        changeAlarm(currentDate)
    }
}

extension WaitingViewModel {
    func loadMapData() {
        let latitude = UserDefaults.standard.double(forKey: Constant.latitude)
        let longitude = UserDefaults.standard.double(forKey: Constant.longitude)
        
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

    func checkAlarmStatus() {
        guard let time = UserDefaults.standard.object(forKey: Constant.nextAlarm) as? Date else { return }
        if (time.timeIntervalSinceNow <= 0) { activateAlarm() }
    }
    
    func activateAlarm() {
        UserDefaults.standard.set(Constant.active, forKey: Constant.alarmStatus)
        HapticManager.instance.vibration()
        NotificationManager.instance.setImmediateRepitition()
    }

    func changeAlarm(_ currentDate: Date) {
        let date = currentDate.zeroSecond
        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)
        
        // Seve New Alarm Data
        UserDefaults.standard.set(hour, forKey: Constant.scheduledHour)
        UserDefaults.standard.set(minute, forKey: Constant.scheduledMinute)
                
        if (Date() >= date) {
            // When the user select past time. Then set tomorrow alarm
            AlarmManager.instance.setTimer(currentDate.tomorrow)
        } else {
            AlarmManager.instance.setTimer(currentDate)
        }
    }    
}


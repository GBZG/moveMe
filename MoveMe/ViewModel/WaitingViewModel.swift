//
//  WaitingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Combine
import Foundation
import MapKit

@MainActor
final class WaitingViewModel: ObservableObject {
    @Published var count = 0
    @Published var alarmTime = ""
    @Published var alarmData: AlarmEntity?
    @Published var history: [HistoryEntity] = []
    @Published var mapLocations: [MapLocation] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    private var cancellables = Set<AnyCancellable>()

    init() {
        setUpTimer()
    }
    
    func onAppear() {
        loadAlarmData()
        loadMapData()
        getAllHistoryRecords()
    }
        
    func onChange() {
        checkAlarmStatus()
    }

    func didTapAlarmChangeButton(_ currentDate: Date) {
        changeAlarm(currentDate)
    }
}

extension WaitingViewModel {
    func loadAlarmData() {
        guard let data = CoreDataManager.instance.getAllAlarms().first else { return }
        alarmData = data
        alarmTime = "\(data.hour) : \(data.minute <= 9 ? "0\(data.minute)" : "\(data.minute)")"
    }
    
    func loadMapData() {
        guard
            let latitude = alarmData?.latitude,
            let longitude = alarmData?.longitude
        else { return }
        
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
    
    func getAllHistoryRecords() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.history = CoreDataManager.instance.getAllHistoryRecords()
        }
    }

    func changeAlarm(_ currentDate: Date) {
        guard let alarmData = alarmData else { return }
        let date = currentDate.zeroSecond
        let hour = Int16(Calendar.current.component(.hour, from: date))
        let minute = Int16(Calendar.current.component(.minute, from: date))
        
        alarmTime = "\(hour) : \(minute <= 9 ? "0\(minute)" : "\(minute)")"
        
        if (Date() >= date) {
            // When the user select past time. Then set tomorrow alarm
            CoreDataManager.instance.editAlarm(
                alarm: alarmData,
                date: currentDate.tomorrow,
                hour: hour,
                minute: minute
            )
            AlarmManager.instance.setTimer(currentDate.tomorrow)
        } else {
            CoreDataManager.instance.editAlarm(
                alarm: alarmData,
                date: currentDate,
                hour: hour,
                minute: minute
            )
            AlarmManager.instance.setTimer(currentDate)
        }
    }
    
    func checkAlarmStatus() {
        guard let time = alarmData?.date as? Date else { return }
        if (time.timeIntervalSinceNow <= 0) { activateAlarm() }
    }
    
    func activateAlarm() {
        UserDefaults.standard.set(Constant.active, forKey: Constant.alarmStatus)
        NotificationManager.instance.setImmediateRepitition()
        HapticManager.instance.vibration()
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
}


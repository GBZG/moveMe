//
//  ContentViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/22.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var locationManager = LocationManager()
    
    func onAppear() {
        locationManager.requestPermission()
        NotificationManager.instance.requestAuth()
        SoundManager.instance.playSilentMusic()
    }
    
    func onDisappear() {
        NotificationManager.instance.sendTerminatedWarning()
    }
}

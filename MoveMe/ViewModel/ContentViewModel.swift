//
//  ContentViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/22.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var locationManager = LocationManager()
    
    func onDisappear() {
        sendTerminationWarning()
    }
}

private extension ContentViewModel {    
    func sendTerminationWarning() {
        NotificationManager.instance.sendTerminatedWarning()
    }
}

//
//  StartingViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/26.
//

import Foundation

final class StartingViewModel: ObservableObject {
    func onAppear() {
        SoundManager.instance.playSilentMusic()
    }
    
    func didTapAccessButton(_ manager: LocationManager) {
        requestAuthentication(manager)
    }
}

private extension StartingViewModel {
    func requestAuthentication(_ manager: LocationManager) {
        manager.requestPermission()
        NotificationManager.instance.requestAuth()
    }
}

//
//  CompletionViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/23.
//

import Foundation

final class CompletionViewModel: ObservableObject {
    func onAppear() {
        AlarmManager.instance.completeAlarm()
        readyForNextAlarm()
    }
    
    func onDisappear() {
        NotificationManager.instance.sendTerminatedWarning()
    }
}

private extension CompletionViewModel {
    func readyForNextAlarm() {
        SoundManager.instance.stopBackgroundMusic()
        SoundManager.instance.playSilentMusic()
        AlarmManager.instance.completeAlarm()
    }
}

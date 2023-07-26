//
//  AlarmViewModel.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

final class AlarmViewModel: ObservableObject {
    func onDisappear() {
        sendTerminationWarning()
    }
}

private extension AlarmViewModel {
    func sendTerminationWarning() {
        NotificationManager.instance.sendTerminatedWarning()
    }
}

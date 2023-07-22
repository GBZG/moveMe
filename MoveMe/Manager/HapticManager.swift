//
//  HapticManager.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import Foundation
import AVFoundation

final class HapticManager {
    static let instance = HapticManager()
    let queue = DispatchQueue(label: "vibration", attributes: .concurrent)
    let workItem = DispatchWorkItem {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    func vibration() {
        if (SoundManager.instance.checkCurrentMusic() == Constant.durationOfAlarmMusic) {
            DispatchQueue(label: "vibration").asyncAfter(deadline: .now() + 1) {
                self.queue.async(execute: self.workItem)
                self.vibration()
            }
        }
    }
}

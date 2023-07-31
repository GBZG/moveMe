//
//  HapticManager.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/01.
//

import UIKit
import AVFoundation

final class HapticManager {
    static let instance = HapticManager()
    let queue = DispatchQueue(label: "vibration", attributes: .concurrent)
    let workItem = DispatchWorkItem {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    func vibration() {
        guard let status = UserDefaults.standard.string(forKey: Constant.alarmStatus) else { return }
        if (status == Constant.active) {
            DispatchQueue(label: "vibration").asyncAfter(deadline: .now() + 1) {
                self.queue.async(execute: self.workItem)
                self.vibration()
            }
        }
    }
    
    func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    
    func hapticWithNotification(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}

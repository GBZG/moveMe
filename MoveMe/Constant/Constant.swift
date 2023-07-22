//
//  Constant.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/22.
//

import SwiftUI

struct Constant {
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
}

// MARK: Alarm Data
extension Constant {
    static let alarmStatus = "alarmStatus"
    static let isAlarmSet = "isAlarmSet"
    static let scheduledHour = "scheduledHour"
    static let scheduledMinute = "scheduledMinute"
    static let originalHour = "originalHour"
    static let originalMinute = "originalMinute"
    
    static let active = "active"
    static let waiting = "waiting"
    static let changed = "changed"
    static let completed = "completed"
    static let discarded = "discarded"
}

// MARK: Location Data
extension Constant {
    static let latitude = "latitude"
    static let longitude = "longitude"
}

// MARK: Notification Identifiers
extension Constant {
    static let notification = "notification"
    static let reminder = "reminder"
    static let terminationWarning = "terminationWarning"
}

// MARK: Sound Data
extension Constant {
    static let durationOfSilentMusic = "60.0"
    static let durationOfAlarmMusic = "213.636375"
}

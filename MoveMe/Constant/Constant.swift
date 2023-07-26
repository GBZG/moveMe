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
    static let nextAlarm = "nextAlarm"
    
    static let active = "active"
    static let waiting = "waiting"
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
    static let repitition = "repitition"
}

// MARK: Sound Data
extension Constant {
    static let durationOfSilentMusic = "60.0"
}

// MARK: Google Ads
extension Constant {
    static let testAdBanner = "ca-app-pub-3940256099942544/2934735716"
    static let realAdBanner = "ca-app-pub-3550877198529803/9445521542"
}

// MARK: Font
extension Constant {
    static let pretendardBold = "Pretendard-Bold"
    static let pretendardMedium = "Pretendard-Medium"
    static let pretendardRegular = "Pretendard-Regular"
}

//
//  Date+.swift
//  MoveMe
//
//  Created by Noah's Ark on 2023/07/02.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    // Return tomorrow the start of tomorrow
    var tomorrow: Date {
        var components = DateComponents()
        components.day = 1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var zeroSecond: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)!
    }
    
    var hourAndMinute: String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return "\(String(format: "%02d", hour)):\(String(format: "%02d", minute))"
    }
    
    var koreanDateForm: String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return "\(year)년 \(month)월 \(day)일"
    }
    
    var americanDateForm: String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return "\(month)-\(day)-\(year)"
    }
    
    var convertToLocalDateForm: String {
        if #available(iOS 16, *) {
            guard let string = Locale.current.language.languageCode?.identifier else { return "" }
            if string == "ko" { return self.koreanDateForm }
            else { return self.americanDateForm}
        } else {
            guard let string = Locale.current.languageCode else { return "" }
            if string == "ko" { return self.koreanDateForm }
            else { return self.americanDateForm}
        }
    }
    
    var historyForm: String {
        let date = self.convertToLocalDateForm
        let time = self.hourAndMinute
        
        return "\(date) \(time)"
    }
}

// MARK: Alarm Setting
extension Date {
    var alarmTimeSetting: Date {
        guard let alarmData = CoreDataManager.instance.getAllAlarms().first else { return Date() }
        var components = DateComponents()
        components.hour = Int(alarmData.hour)
        components.minute = Int(alarmData.minute)
        components.second = 0
        
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
        
    var alarmTimeOfTomorrow: Date {
        guard let alarmData = CoreDataManager.instance.getAllAlarms().first else { return Date() }
        var components = DateComponents()
        components.hour = Int(alarmData.hour)
        components.minute = Int(alarmData.minute)
        components.second = 0
        
        return Calendar.current.date(byAdding: components, to: tomorrow)!
    }
}

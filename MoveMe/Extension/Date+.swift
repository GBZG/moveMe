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
    
    var hourAndMinute: String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return "\(hour)시 \(minute)분"
    }
}

// MARK: Alarm Setting
extension Date {
    var originalAlarmTimeSetting: Date {
        var components = DateComponents()
        components.hour = UserDefaults.standard.integer(forKey: Constant.originalHour)
        components.minute = UserDefaults.standard.integer(forKey: Constant.originalMinute)
        components.second = 0
        
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var changedAlarmTimeSetting: Date {
        var components = DateComponents()
        components.hour = UserDefaults.standard.integer(forKey: Constant.scheduledHour)
        components.minute = UserDefaults.standard.integer(forKey: Constant.scheduledMinute)
        components.second = 0
        
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var originalAlarmForTomorrow: Date {
        var components = DateComponents()
        components.hour = UserDefaults.standard.integer(forKey: Constant.originalHour)
        components.minute = UserDefaults.standard.integer(forKey: Constant.originalMinute)
        components.second = 0
        
        return Calendar.current.date(byAdding: components, to: tomorrow)!
    }
}

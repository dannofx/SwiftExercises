//
//  AlarmViewModel.swift
//  MVVCAlarmExample
//
//  Created by Danno on 3/6/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import UIKit

class AlarmViewModel: NSObject {
    let alarm: Alarm
    let numberOfSections = 1
    let possibleSounds = ["Bell", "Fire", "Explosion", "Morning birds", "Klaxon"]
    
    init(alarm: Alarm) {
        self.alarm = alarm
    }
    
    func updateTime(_ date: Date) {
        self.alarm.time = date
    }
    
    func updateSound(_ sound: String) {
        self.alarm.sound = sound
    }
    
    var isTimeSet: Bool {
        return self.alarm.time != nil
    }
    
    var isSoundSet: Bool {
        return self.alarm.sound != nil
    }
    
    var isAlarmEnabled: Bool {
        get {
            return self.alarm.isEnabled
        }
        
        set (newValue) {
            self.alarm.isEnabled = newValue
        }
    }
    
    var soundName: String {
        return self.alarm.sound ?? "(No sound set)"
    }
    
    var stringTime: String {
        if let date = self.alarm.time {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            return formatter.string(from: date)
        } else {
            return "(No time set)"
        }
    }
    
    var numberOfRows: Int {
        if self.isAlarmEnabled {
            return 3
        } else {
            return 1
        }
    }
    
}

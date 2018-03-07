//
//  Alarm.swift
//  MVVCAlarmExample
//
//  Created by Danno on 3/6/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import UIKit

class Alarm: NSObject {
    var isEnabled: Bool
    var time: Date?
    var sound: String?
    
    override init() {
        self.isEnabled = false
    }
}

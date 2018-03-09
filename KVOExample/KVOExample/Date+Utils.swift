//
//  Date+Utils.swift
//  KVOExample
//
//  Created by Danno on 3/8/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import UIKit

extension Date {
    
    var string: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

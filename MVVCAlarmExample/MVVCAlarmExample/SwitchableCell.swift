//
//  SwitchableCell.swift
//  MVVCAlarmExample
//
//  Created by Danno on 3/6/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import UIKit

class SwitchableCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var stateSwitch: UISwitch!
    var switchHandler: ((SwitchableCell) -> Void)?
    
    
    @IBAction func switchDidChange(sender: UISwitch) {
        self.switchHandler?(self)
    }
}

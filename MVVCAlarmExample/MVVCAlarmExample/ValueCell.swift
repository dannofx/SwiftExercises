//
//  TimeCell.swift
//  MVVCAlarmExample
//
//  Created by Danno on 3/6/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import UIKit

class ValueCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var focusHandler: ((ValueCell) -> Void)?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didEnterOnEdition(sender: UITextField) {
        self.focusHandler?(self)
    }

}

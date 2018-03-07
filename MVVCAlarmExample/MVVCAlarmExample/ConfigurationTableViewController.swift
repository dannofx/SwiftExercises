//
//  ConfigurationTableViewController.swift
//  MVVCAlarmExample
//
//  Created by Danno on 3/6/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import UIKit

class ConfigurationTableViewController: UITableViewController {
    var alarmViewModel: AlarmViewModel!
    let datePicker = UIDatePicker()
    let soundPicker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 44.0
        self.soundPicker.delegate = self
        self.soundPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func finish() {
        if self.alarmViewModel.isAlarmEnabled {
            if !self.alarmViewModel.isTimeSet ||
                !self.alarmViewModel.isSoundSet {
                let alert = UIAlertController(title: "Incomplete information",
                                              message: "If you are going to enable the alarm, set the corresponding time and sound.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        self.dismiss(animated: true, completion: nil)
    }

}
// MARK: - Table view data source and delegate
extension ConfigurationTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.alarmViewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.alarmViewModel.numberOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var resultCell = UITableViewCell()
        
        switch indexPath.row {
        // Enable cell
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.swtichCell) as? SwitchableCell {
                cell.titleLabel.text = "Enabled"
                cell.stateSwitch.isOn = self.alarmViewModel.isAlarmEnabled
                cell.switchHandler = { switchCell in
                    self.alarmViewModel.isAlarmEnabled = switchCell.stateSwitch.isOn
                    let indexes = [
                        IndexPath(row: 1, section: indexPath.section),
                        IndexPath(row: 2, section: indexPath.section)
                    ]
                    if switchCell.stateSwitch.isOn {
                        self.tableView.insertRows(at: indexes, with: .top)
                    } else {
                        self.tableView.deleteRows(at: indexes, with: .top)
                    }
                }
                resultCell = cell
            }
        // Time cell
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.valueCell) as? ValueCell {
                cell.titleLabel.text = "Time"
                cell.textField.text = self.alarmViewModel.stringTime
                cell.focusHandler = { valueCell in
                    self.showDatePicker(onField: valueCell.textField)
                }
                resultCell = cell
            }
        // Sound cell
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.valueCell) as? ValueCell {
                cell.titleLabel.text = "Sound"
                cell.textField.text = self.alarmViewModel.soundName
                cell.focusHandler = { valueCell in
                    self.showSoundPicker(onField: valueCell.textField)
                }
                resultCell = cell
            }
        }
        return resultCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        // Enable cell
        case 0:
            break
        // Time cell
        case 1:
            if let cell = tableView.cellForRow(at: indexPath) as? ValueCell {
                self.showDatePicker(onField: cell.textField)
            }
        // Sound Cell
        default:
            if let cell = tableView.cellForRow(at: indexPath) as? ValueCell {
                self.showSoundPicker(onField: cell.textField)
            }
            break
        }
    }


}

// MARK: - Date Picker

extension ConfigurationTableViewController {
    func showDatePicker(onField textField: UITextField) {
        datePicker.datePickerMode = .dateAndTime
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didSelectDate))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelDateSelection))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        textField.becomeFirstResponder()
    }
    
    @objc
    func didSelectDate() {
        self.alarmViewModel.updateTime(self.datePicker.date)
        self.view.endEditing(true)
        self.tableView.beginUpdates()
        let indexPath = IndexPath(row: 1, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
    
    @objc
    func didCancelDateSelection() {
        self.view.endEditing(true)
    }
}

// MARK: - Sound Picker

extension ConfigurationTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func showSoundPicker(onField textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didSelectSound))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSoundSelection))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = soundPicker
        textField.becomeFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.alarmViewModel.possibleSounds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.alarmViewModel.possibleSounds[row]
    }
    
    @objc
    func didSelectSound() {
        let sound = self.alarmViewModel.possibleSounds[self.soundPicker.selectedRow(inComponent: 0)]
        self.alarmViewModel.updateSound(sound)
        self.view.endEditing(true)
        self.tableView.beginUpdates()
        let indexPath = IndexPath(row: 2, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
    
    @objc
    func didCancelSoundSelection() {
        self.view.endEditing(true)
    }
}


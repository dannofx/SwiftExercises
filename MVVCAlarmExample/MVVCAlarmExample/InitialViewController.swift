//
//  InitialViewController.swift
//  MVVCAlarmExample
//
//  Created by Danno on 3/6/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    let alarm = Alarm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.configSegue {
            guard let navController = segue.destination as? UINavigationController else {
                return
            }
            guard let configViewController = navController.viewControllers.first as? ConfigurationTableViewController else {
                return
            }
            let alarmModelView = AlarmViewModel(alarm: self.alarm)
            configViewController.alarmViewModel = alarmModelView
        }
    }
}

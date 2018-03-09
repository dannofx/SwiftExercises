//
//  ViewController.swift
//  KVOExample
//
//  Created by Danno on 3/8/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import UIKit

private var tag = 8

class ViewController: UIViewController {
    @IBOutlet var timeLabel: UILabel!
    // date is the variable to be observed, following is the
    // explanation for its modifiers:
    // @objc:   Needs to be recognized by the Objective-C runtime
    //          since KVO works over Objective-C
    // dynamic: Is not really necessary, but using it let us ignore
    //          the KVC syntax.
    @objc private dynamic var date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Adds KVO observer using tag as context
        self.addObserver(self, forKeyPath: #keyPath(date), options: [.old, .new, .initial], context: &tag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // The button triggers the date update, but not the label update
    @IBAction func updateDate() {
        self.date = Date()
    }
    
    // The change in the value is notified in this method
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // Checks if the keypath and tag is the same, so the change can be taken into account.
        if keyPath == #keyPath(date) && context == &tag {
            // Retrieves the old and new value
            print("--")
            guard let newValue = change?[NSKeyValueChangeKey.newKey] as? Date else { return }
            print("New value: \(newValue.string)")
            self.timeLabel.text = newValue.string
            guard let oldValue = change?[NSKeyValueChangeKey.oldKey] as? Date else { return }
            print("Old value: \(oldValue.string)")
        }
    }

    deinit {
        // Removes the observer for certain keypath and context
        self.removeObserver(self, forKeyPath: #keyPath(date), context: &tag)
    }
}


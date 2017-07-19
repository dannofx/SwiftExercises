//
//  ViewController.swift
//  AutoresizingMasks
//
//  Created by Danno on 7/18/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let smallRect = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
    let bigRect = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0)
    

    @IBOutlet weak var drawingView: UIView!
    @IBOutlet var resizeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawingView.autoresizesSubviews = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func modifySize() {
        self.drawingView.frame = self.smallRect
        self.resizeView.frame = self.smallRect
        UIView.animate(withDuration: 2.0) {
            self.drawingView.frame = self.bigRect
        }
    }
    
    @IBAction func effect1(_ sender: Any) {
        self.resizeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.modifySize()
    }
    
    @IBAction func effect2(_ sender: Any) {
        self.resizeView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        self.modifySize()
    }
    
    @IBAction func effect3(_ sender: Any) {
        self.resizeView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        self.modifySize()
    }
    
    @IBAction func effect4(_ sender: Any) {
        self.resizeView.autoresizingMask = [.flexibleWidth]
        self.modifySize()
    }
    
    @IBAction func effect5(_ sender: Any) {
        self.resizeView.autoresizingMask = [.flexibleHeight]
        self.modifySize()
    }
    
    @IBAction func effect6(_ sender: Any) {
        self.resizeView.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        self.modifySize()
    }
    


}


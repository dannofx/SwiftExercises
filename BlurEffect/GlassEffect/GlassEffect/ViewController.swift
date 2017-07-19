//
//  ViewController.swift
//  GlassEffect
//
//  Created by Danno on 7/17/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showCodeViewController(sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: CodeViewController.self))
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true)
    }

    @IBAction func unwindToMainController(segue:UIStoryboardSegue) {
    }


}


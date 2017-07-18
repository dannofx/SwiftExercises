//
//  CodeViewController.swift
//  GlassEffect
//
//  Created by Danno on 7/18/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Color
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        // Effect view
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectSubView = UIVisualEffectView(effect: blurEffect)
        blurEffectSubView.frame = self.view.bounds
        self.view.addSubview(blurEffectSubView)
        //Button
        let button = UIButton.init(frame: CGRect(x: 30.0, y: 30.0, width: 76.0, height: 30.0))
        button.setTitle("HIDE", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(hide), for: .touchUpInside)
        self.view.addSubview(button)
        
        // Constraints
        let views = ["effectView": blurEffectSubView,
                     "button": button ] as [String: UIView]
        var constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[effectView]|",
                                                        options: [],
                                                        metrics: nil,
                                                        views: views)
        self.view.addConstraints(constraint)
        constraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[effectView]|",
                                                        options: [],
                                                        metrics: nil,
                                                        views: views)
        self.view.addConstraints(constraint)
        
        constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:[button(76)]", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: views)
        self.view.addConstraints(constraint)
        constraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[button(30)]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views)
        self.view.addConstraints(constraint)
        
        self.view.setNeedsUpdateConstraints()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func hide() {
        self.dismiss(animated: true)
    }

}

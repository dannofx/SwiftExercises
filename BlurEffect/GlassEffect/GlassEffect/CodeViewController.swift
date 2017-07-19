//
//  CodeViewController.swift
//  GlassEffect
//
//  Created by Danno on 7/18/17.
//  Copyright © 2017 Daniel Heredia. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {
    
    var blurEffectSubView: UIView!
    var button: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()

    }
    
    func setupViews() {
        // Color
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        // Effect view
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectSubView = UIVisualEffectView(effect: blurEffect)
        blurEffectSubView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(blurEffectSubView)
        //Button
        button = UIButton()
        button.setTitle("HIDE", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(hide), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
    }
    
    func setupConstraints() {
        // Constraints
        let views = ["superview": self.view,
                     "effectView": blurEffectSubView,
                     "button": button ] as [String: UIView]
        var constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[effectView]|",
                                                        options: [],
                                                        metrics: nil,
                                                        views: views)
        self.view.addConstraints(constraint)
        NSLayoutConstraint.activate(constraint)
        constraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[effectView]|",
                                                    options: [],
                                                    metrics: nil,
                                                    views: views)
        self.view.addConstraints(constraint)
        
        constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:[superview]-(<=1)-[button(76)]", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: views)
        self.view.addConstraints(constraint)
        
        constraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[button(30)]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views)
        self.view.addConstraints(constraint)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func hide() {
        self.dismiss(animated: true)
    }

}

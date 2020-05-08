/*
 * FILE : TabBarController.swift
 * PROJECT : PROG3230 - Mobile Application Development II - Assignment 1
 * PROGRAMMERS : David Pitters, Lev Cocarell, Carl Wilson, Bobby Vu
 * FIRST VERSION : 2018-09-15
 * DESCRIPTION :
 * This file contains the source code for the TabBarController.
 */

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet var tabBarNav: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // These are UI modifications of the TabBarController to allow larger font than out the box
        // tab bar controller.
        let attrsNormal = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0)
        ]
        let attrsSelected = [
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0)
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(attrsNormal, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attrsSelected, for: .selected)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


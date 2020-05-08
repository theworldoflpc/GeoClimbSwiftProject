//
//  SelectableLabel.swift
//  GeoClimb
//
//  Created by Carl Wilson on 2018-12-03.
//  Copyright © 2018 qualityoverload2. All rights reserved.
//
// BASED OFF OF A SOLUTION FROM https://stephenradford.me/make-uilabel-copyable/
import UIKit

class SelectableLabel: UILabel {
    
    override public var canBecomeFirstResponder: Bool {
        return true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        isUserInteractionEnabled = true
        highlightedTextColor = UIColor(displayP3Red: 0, green: 0.0, blue: 1.0, alpha: 1.0)
        
        addGestureRecognizer(UILongPressGestureRecognizer(
            target: self,
            action: #selector(showMenu(sender:))
        ))
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didHideEditMenu),
            name: NSNotification.Name.UIMenuControllerDidHideMenu,
            object: nil)
    }
    
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }
    
    @objc func showMenu(sender: Any?) {
        isHighlighted = true
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return (action == #selector(copy(_:)))
    }
    
    @objc func didHideEditMenu(sender: Any?) {
        isHighlighted = false
    }
}

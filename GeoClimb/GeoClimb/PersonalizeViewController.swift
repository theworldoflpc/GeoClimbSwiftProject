/*
 * FILE : PersonalizeViewController.swift
 * PROJECT : PROG3230 - Mobile Application Development II - Assignment 1
 * PROGRAMMERS : David Pitters, Lev Cocarell, Carl Wilson, Bobby Vu
 * FIRST VERSION : 2018-09-15
 * DESCRIPTION :
 * This file contains the source code for the PersonalizeViewController.
 * This view controller is a simple demonstration of a text field input control,
 * asking for a user's entry. This page handles dismissal of keyboard ui as well.
 */

import UIKit

class PersonalizeViewController: UIViewController, UITextFieldDelegate {
  
    @IBOutlet weak var label_Name: UILabel!
    @IBOutlet weak var label_Location: UILabel!
    @IBOutlet weak var label_LocationCust: UILabel!
    @IBOutlet weak var textField_name: UITextField!
    @IBOutlet weak var textField_Location: UITextField!
    
    // This event allows user to submit their location, depending if they have
    // entered anything in text field.
    @IBAction func button_SubmitLocation(_ sender: Any) {
        textField_Location.resignFirstResponder()
        label_Location.text = textField_Location.text
        label_Location.isHidden = false
    }
    
    // This event allows user to submit their name, depending if they have
    // entered anything in text field. The output label is hidden until user submits anything.
    @IBAction func button_Submit(_ sender: Any) {
        textField_name.resignFirstResponder()
        label_Name.text = textField_name.text
        label_Name.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label_Name.isHidden = true
        label_Location.isHidden = true
        
        //Set the text field delegates
        textField_name.delegate = self
        textField_Location.delegate = self
        
        self.HideKeyboard();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func HideKeyboard() {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

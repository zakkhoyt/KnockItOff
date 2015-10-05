//
//  SettingsNotificationsViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/31/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class SettingsNotificationsViewController: UIViewController {

    @IBOutlet private weak var successLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var promptButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        updateControls(appDelegate.notificationStatus)
    }
    
    @IBAction func promptButtonTouchUpInside(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.promptForNotifcations { (status) -> (Void) in
            self.updateControls(status)
        }
    }
    
    func updateControls(status: NotificationStatus) {
        switch status {
        case .NotPrompted:
            print("Not Prompted")
            promptButton?.hidden = false
            nextButton?.hidden = true
            successLabel?.hidden = true
            datePicker?.hidden = true
            
        case .Authorized:
            print("Authorized")
            promptButton?.hidden = true
            nextButton?.hidden = false
            successLabel?.hidden = true
            datePicker?.hidden = false
            
        case .Denied:
            print("Denied")
            promptButton?.hidden = true
            nextButton?.hidden = false
            successLabel?.hidden = false
            datePicker?.hidden = true
        }

    }
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        KnockItOffPersistant.sharedInstance().setLocalNotifications(true)
        KnockItOffPersistant.sharedInstance().setAlarmTime(sender.date)
    }
    
}

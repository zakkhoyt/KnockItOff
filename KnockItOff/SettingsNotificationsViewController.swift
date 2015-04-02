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

//        let status: UIUserNotificationSettings? = UIApplication.sharedApplication().currentUserNotificationSettings()
//        let types = status?.types


        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let status: NotificationStatus = appDelegate.notificationStatus
        
        switch status {
        case .NotPrompted:
            println("Not Prompted")
            promptButton?.hidden = false
            nextButton?.hidden = true
            successLabel?.hidden = true
            datePicker?.hidden = true

        case .Authorized:
            println("Authorized")
            promptButton?.hidden = true
            nextButton?.hidden = false
            successLabel?.hidden = false
            datePicker?.hidden = false

        case .Denied:
            println("Denied")
            promptButton?.hidden = true
            nextButton?.hidden = false
            successLabel?.hidden = false
            datePicker?.hidden = true
        }
    }
    
    @IBAction func promptButtonTouchUpInside(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.promptForNotifcations { (status) -> (Void) in
            switch status {
            case .NotPrompted:
                println("Not Prompted")
            case .Authorized:
                println("Authorized")
            case .Denied:
                println("Denied")
            }
        }
        
//        successLabel?.hidden = false
//        promptButton?.hidden = true
//        nextButton?.hidden = false
    }
}
//
//  SettingsNotificationsViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/31/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class SettingsNotificationsViewController: UIViewController {

    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var promptButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let status: UIUserNotificationSettings? = UIApplication.sharedApplication().currentUserNotificationSettings()
        let types = status?.types

//        if UIApplication.sharedApplication().enabledRemoteNotificationTypes() {
//            println("already got notification permission")
//            promptButton?.hidden = true
//            nextButton?.hidden = false
//            successLabel?.hidden = false
//            
//        } else {
//            println("none. Display notifiation permissions")
//            promptButton?.hidden = false
//            nextButton?.hidden = true
//            successLabel?.hidden = true
//        }
        if types == UIUserNotificationType.None {
            println("none. Display notifiation permissions")
            promptButton?.hidden = false
            nextButton?.hidden = true
            successLabel?.hidden = true
        } else {
            println("already got notification permission")
            promptButton?.hidden = true
            nextButton?.hidden = false
            successLabel?.hidden = false
        }
    }

    @IBAction func promptButtonTouchUpInside(sender: AnyObject) {
        let status: UIUserNotificationSettings? = UIApplication.sharedApplication().currentUserNotificationSettings()
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        
        successLabel?.hidden = false
        promptButton?.hidden = true
        nextButton?.hidden = false
    }
}

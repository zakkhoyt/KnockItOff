//
//  SettingsTableViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/22/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import KnockItOffKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var lastDrinkDatelabel: UILabel!
    @IBOutlet weak var notificationTimePicker: UIDatePicker!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        // Add a done button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonAction")
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.hidesBackButton = true
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let summary = KnockItOffPersistant.sharedInstance().summary()
        
        self.lastDrinkDatelabel.text = summary.startDateString
        self.twoLabel.sizeToFit()
        self.todayLabel.sizeToFit()
        
        let alarmTime = KnockItOffPersistant.sharedInstance().alarmTime()
        if alarmTime != nil {
            self.notificationTimePicker.date = alarmTime
        } else {
            // IB set it to 6:00 AM
        }
        
        notificationsSwitch.on = KnockItOffPersistant.sharedInstance().localNotifications()
        notificationTimePicker.enabled = notificationsSwitch.on
        notificationTimePicker.userInteractionEnabled = notificationsSwitch.on
        notificationTimePicker.alpha = notificationsSwitch.on ? 1.0 : 0.5
    }

    @IBAction func notificationSwitchValueChanged(sender: UISwitch) {
        KnockItOffPersistant.sharedInstance().setLocalNotifications(sender.on)
        notificationTimePicker.enabled = sender.on
        notificationTimePicker.userInteractionEnabled = notificationsSwitch.on
        notificationTimePicker.alpha = notificationsSwitch.on ? 1.0 : 0.5
    }
    
    func doneButtonAction() {
        let alarmTime = notificationTimePicker.date
        KnockItOffPersistant.sharedInstance().setAlarmTime(alarmTime)
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}

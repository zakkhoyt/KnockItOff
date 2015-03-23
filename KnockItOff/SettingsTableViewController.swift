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
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneButtonAction")
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.hidesBackButton = true
        title = "Settings"
        
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.lastDrinkDatelabel.text = VWWUserDefaults.sharedInstance().startDateString()
//        self.twoLabel.text = "For quick access move the app to the bottom bar For quick access move the app to the bottom bar"
        self.twoLabel.sizeToFit()
        self.todayLabel.sizeToFit()
    }

    @IBAction func notificationSwitchValueChanged(sender: UISwitch) {
    }
    
    @IBAction func lastDrinkButtonTouchUpInsde(sender: AnyObject) {
        
    }
    
    func doneButtonAction() {
//        navigationController?.popViewControllerAnimated(true)
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    

}

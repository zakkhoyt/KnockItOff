//
//  SettingsLastDrinkViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/31/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class SettingsLastDrinkViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    private var context = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let date: NSDate? = KnockItOffPersistant.sharedInstance().startDate()
        if date == nil {
            datePicker!.date = NSDate()
        } else {
            datePicker!.setDate(date!, animated: true)
        }
        
        
        //KnockItOffPersistant.sharedInstance().setStartDate(datePicker.date)
        
    }
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        KnockItOffPersistant.sharedInstance().setStartDate(datePicker.date)
    }
}


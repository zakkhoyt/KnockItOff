//
//  DatePickerViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import KnockItOffKit


class DatePickerViewController: UIViewController{
    
    let defaults = VWWUserDefaults.sharedInstance()
    
    @IBOutlet weak var datePicker: RSDFDatePickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.dataSource = self
        datePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}


extension DatePickerViewController: RSDFDatePickerViewDataSource{
    func datePickerView(view: RSDFDatePickerView!, shouldMarkDate date: NSDate!) -> Bool {
        let startDate = defaults.startDate()
        if startDate == nil{
            return false
        }
        
        if date.isEqualToDate(defaults.startDate()){
            return true
        } else {
            return false
        }
    }

    func datePickerView(view: RSDFDatePickerView!, isCompletedAllTasksOnDate date: NSDate!) -> Bool {
        return false
    }
}


extension DatePickerViewController: RSDFDatePickerViewDelegate{
    func datePickerView(view: RSDFDatePickerView!, didSelectDate date: NSDate!) {
        println("selected date: " + date.description)
        defaults.setStartDate(date)
    }
    
    func datePickerView(view: RSDFDatePickerView!, shouldSelectDate date: NSDate!) -> Bool {
        return true;
    }

}

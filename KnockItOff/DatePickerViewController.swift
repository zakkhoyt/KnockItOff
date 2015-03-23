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
    
    let defaults = KnockItOffPersistant.sharedInstance()
    
    @IBOutlet weak var datePicker: RSDFDatePickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.dataSource = self
        datePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let startDate = defaults.startDate()
        if startDate != nil{
            datePicker.selectDate(startDate)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


extension DatePickerViewController: RSDFDatePickerViewDataSource{
    func datePickerView(view: RSDFDatePickerView!, shouldMarkDate date: NSDate!) -> Bool {
        let startDate = defaults.startDate()
        if startDate == nil{
            return false
        }
        
        if date.timeIntervalSince1970 >= startDate.timeIntervalSince1970 &&
        date.timeIntervalSince1970 < NSDate().timeIntervalSince1970 {
            return true
        } else {
            return false
        }
        
        
//        if date.isEqualToDate(defaults.startDate()){
//            return true
//        } else {
//            return false
//        }
    }

    func datePickerView(view: RSDFDatePickerView!, isCompletedAllTasksOnDate date: NSDate!) -> Bool {
        return false
    }
}


extension DatePickerViewController: RSDFDatePickerViewDelegate{
    func datePickerView(view: RSDFDatePickerView!, didSelectDate date: NSDate!) {
        println("selected date: " + date.description)
        defaults.setStartDate(date)
        datePicker.reloadData()
        datePicker.selectDate(date)
    }
    
    func datePickerView(view: RSDFDatePickerView!, shouldSelectDate date: NSDate!) -> Bool {
        return true;
    }

}
extension DatePickerViewController: UINavigationBarDelegate{
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
}
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
    var datePickerHidden = false;
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
//        self.twoLabel.sizeToFit()
//        self.todayLabel.sizeToFit()
        
        let alarmTime = KnockItOffPersistant.sharedInstance().alarmTime()
        if alarmTime != nil {
            self.notificationTimePicker.date = alarmTime
        } else {
            // IB set it to 6:00 AM
        }
        
        notificationsSwitch.on = KnockItOffPersistant.sharedInstance().localNotifications()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.twoLabel.sizeToFit()
        self.todayLabel.sizeToFit()
        
    }
    @IBAction func notificationTimeButtonTouchUpInside(sender: AnyObject) {
        datePickerHidden = !datePickerHidden
        let indexPath = NSIndexPath(forRow: 1, inSection: 2)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    
    func doneButtonAction() {
        let alarmTime = notificationTimePicker.date
        KnockItOffPersistant.sharedInstance().setAlarmTime(alarmTime)
        KnockItOffPersistant.sharedInstance().setLocalNotifications(notificationsSwitch.on)
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    
    @IBAction func testButtonAction(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Settings", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateInitialViewController() as UIViewController
        presentViewController(vc, animated: true, completion: nil)        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 && indexPath.section == 2 {
            if datePickerHidden {
                println("--------------------- 0")
                return 0.001
            } else {
                println("--------------------- 162")
                return 162
            }
        }
        return super.tableView(tableView, heightForRowAtIndexPath:indexPath)
    }

    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 30))
        headerView.backgroundColor = UIColor.clearColor()
        let label = UILabel(frame: CGRectMake(8,
            (30 - 21)/2.0,
            self.view.bounds.size.width - 2*8,
            30))
        
        label.textAlignment = NSTextAlignment.Left
        label.textColor = UIColor.yellowColor()
        label.font = UIFont.systemFontOfSize(22)

        headerView.addSubview(label)
        
        switch section {
        case 0:
            label.text = "1.) Enter the date of your last drink"
        case 1:
            label.text = "2.) Check your status any time"
        case 2:
            label.text = "3.) Daily notification"
        case 3:
            label.text = "4.) Today tab"
        case 4:
            label.text = "5.) Get help"
        case 5:
            label.text = "6.) About this app"
        case 6:
            label.text = ""
        default:
            label.text = ""
            
        }
        return headerView
    }

    
    
    // Hide empty cells
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
   
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("tap")
    }
}



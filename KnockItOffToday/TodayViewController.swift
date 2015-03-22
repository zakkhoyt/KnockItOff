//
//  TodayViewController.swift
//  KnockItOffToday
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//
// 1-6 day (1) "1 day" - yellow smiley face  with red border
// 7-13 days (1) "7 days" - yellow circle with red border and red week number
// 31-61 days (1) "31 days" - Yellow star with red border and green text
// 365+ (1) "365 days" Yellow start with black smiley face and red border


import UIKit
import NotificationCenter
import KnockItOffKit

class TodayViewController: UIViewController, NCWidgetProviding {
    let defaults = VWWUserDefaults.sharedInstance()
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(0, 44);
        
        let startDate: NSDate? = defaults.startDate()
        
        if startDate != nil {
            let seconds = NSDate().timeIntervalSinceDate(startDate!)
            let days = Int(seconds / (60*60*24))
            startDateLabel.text = "\(days) days since your last drink"
            setImageForDays(days)
        } else {
            startDateLabel.text = "Open KnockItOff to setup a quitting date."
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func setImageForDays(days:Int){
        switch days{
        case 0...6:
            imageView.image = UIImage(named: "Circle")
        case 7...30:
            imageView.image = UIImage(named: "Circle")
        case 31...364:
            imageView.image = UIImage(named: "Star")
        case 365...100000000:
            imageView.image = UIImage(named: "Star")
        default:
            imageView.image = nil
        }
    }
    
}

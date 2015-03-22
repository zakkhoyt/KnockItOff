//
//  TodayViewController.swift
//  KnockItOffToday
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//


import UIKit
import NotificationCenter
import KnockItOffKit

class TodayViewController: UIViewController, NCWidgetProviding {
    let defaults = VWWUserDefaults.sharedInstance()
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(0, 60
        );
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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

    
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
}

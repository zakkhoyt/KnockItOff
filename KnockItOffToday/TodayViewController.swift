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
    let defaults = KnockItOffPersistant.sharedInstance()
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageStringLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(0, 60);
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let startDate: NSDate? = defaults.startDate()
        
        if startDate != nil {
            self.imageView.image = KnockItOffPersistant.sharedInstance().imageForStartDate()
            self.imageStringLabel.text = KnockItOffPersistant.sharedInstance().imageStringForStartDate()
            self.imageStringLabel.textColor = KnockItOffPersistant.sharedInstance().imageStringColorForStartDate()
            self.statusLabel.text = KnockItOffPersistant.sharedInstance().statusStringForStartDate()

        } else {
            statusLabel.text = "Open 'Knock It Off' to setup a quitting date."
        }

    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
}

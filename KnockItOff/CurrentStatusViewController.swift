//
//  CurrentStatusViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import KnockItOffKit

class CurrentStatusViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageStringLabel: UILabel!
    @IBOutlet weak var statusTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.imageView.image = VWWUserDefaults.sharedInstance().imageForStartDate()
        self.imageStringLabel.text = VWWUserDefaults.sharedInstance().imageStringForStartDate()
        self.imageStringLabel.textColor = VWWUserDefaults.sharedInstance().imageStringColorForStartDate()

        let attrString = NSMutableAttributedString()
        var insertPoint: Int = 0
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .Center
        
        let attr1 = [NSParagraphStyleAttributeName : paragraph,
            NSForegroundColorAttributeName : UIColor.darkTextColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(32)]

        let str1 = NSString(format: "%@ ", VWWUserDefaults.sharedInstance().statusStringForStartDate())
        attrString.appendAttributedString(NSAttributedString(string: str1))
        attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
        insertPoint += str1.length
        
        let attr2 = [NSParagraphStyleAttributeName : paragraph,
            NSForegroundColorAttributeName : UIColor.darkTextColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(24)]
        let str2 = NSString(format: "(%@)\n", VWWUserDefaults.sharedInstance().startDateString())
        attrString.appendAttributedString(NSAttributedString(string: str2))
        attrString.setAttributes(attr2, range: NSMakeRange(insertPoint, str2.length))
        insertPoint += str2.length

        self.statusTextView.attributedText = attrString
        
        scheduleNotification();
        
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func scheduleNotification(){
        
        let status: UIUserNotificationSettings? = UIApplication.sharedApplication().currentUserNotificationSettings()
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        
        for day in 1...30 {
            // schedule notification for tomorrow
            var notification = UILocalNotification()
            notification.timeZone = NSTimeZone.defaultTimeZone()
            var dateTime = NSDate(timeInterval: 10, sinceDate: NSDate())
            let futureDate = dateForDaysFromNow(day)
            notification.fireDate = futureDate
            notification.alertBody = VWWUserDefaults.sharedInstance().statusStringForStartDate()
            notification.alertTitle = VWWUserDefaults.sharedInstance().statusStringForStartDate()
            notification.applicationIconBadgeNumber = 1;
            let localTimeDescription = futureDate.descriptionWithLocale(NSLocale.currentLocale())
            println("fireDate: " + localTimeDescription!)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func dateForDaysFromNow(daysfromNow: Int) -> NSDate {
        let now = NSDate()
        let tomorrowComponents = NSDateComponents()
        tomorrowComponents.day = daysfromNow;
        
        let calendar = NSCalendar.currentCalendar()
        
        let tomorrow = calendar.dateByAddingComponents(tomorrowComponents, toDate: now, options: nil)
        
        let tomorrowMorningComponents = calendar.components(.CalendarUnitEra | .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: tomorrow!)
        tomorrowMorningComponents.hour = 6
        
        let tomorrowMorning = calendar.dateFromComponents(tomorrowMorningComponents)
        return tomorrowMorning!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

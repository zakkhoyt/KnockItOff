
//
//  NotificationScheduler.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import KnockItOffKit


class NotificationScheduler: NSObject {
    class func scheduleNotifications(){
        // Ask for permission
        let status: UIUserNotificationSettings? = UIApplication.sharedApplication().currentUserNotificationSettings()
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Alert, UIUserNotificationType.Badge], categories: nil))
        
        unscheduleNotifications()
        
        // Schedule daily notification for next 30 days
        for day in 0...30 {
            // schedule notification for tomorrow
            var notification = UILocalNotification()
            notification.timeZone = NSTimeZone.defaultTimeZone()
            let futureDate = dateForDaysFromNow(day)
            notification.fireDate = futureDate
            let summary = KnockItOffPersistant.sharedInstance().summary()
            summary.currentDate = futureDate;
            notification.alertBody = summary.daysQuitString
            if #available(iOS 8.2, *) {
                notification.alertTitle = summary.timeQuitString
            } else {
                // Fallback on earlier versions
            }
            notification.applicationIconBadgeNumber = summary.daysQuit.unsignedIntegerValue
            let localTimeDescription = futureDate.descriptionWithLocale(NSLocale.currentLocale())
            print("fireDate: " + localTimeDescription)
            print("alert: " + summary.daysQuitString)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        // Set current date back to now
        let summary = KnockItOffPersistant.sharedInstance().summary()
        summary.currentDate = NSDate()

        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 99
    }
    
    class func unscheduleNotifications() {
        // Cancel all previously scheduled notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        print("Unscheduled all notifications")
    }
    
    class func dateForDaysFromNow(daysfromNow: Int) -> NSDate {
        
        let alarmDate = KnockItOffPersistant.sharedInstance().alarmTime()
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components(([.Hour, .Minute]), fromDate: alarmDate)
        let hour = comp.hour
        let minute = comp.minute
        
        let now = NSDate()
        let tomorrowComponents = NSDateComponents()
        tomorrowComponents.day = daysfromNow;
        
        
        
        let tomorrow = calendar.dateByAddingComponents(tomorrowComponents, toDate: now, options: [])
        
        let tomorrowMorningComponents = calendar.components([.Era, .Year, .Month, .Day], fromDate: tomorrow!)
        tomorrowMorningComponents.hour = hour
        tomorrowMorningComponents.minute = minute
        
        let tomorrowMorning = calendar.dateFromComponents(tomorrowMorningComponents)
        return tomorrowMorning!
    }
}

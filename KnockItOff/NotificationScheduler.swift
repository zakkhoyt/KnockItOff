
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
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        
        // Cancel all previously scheduled notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        // Schedule daily notification for next 30 days
        for day in 1...30 {
            // schedule notification for tomorrow
            var notification = UILocalNotification()
            notification.timeZone = NSTimeZone.defaultTimeZone()
            var dateTime = NSDate(timeInterval: 10, sinceDate: NSDate())
            let futureDate = dateForDaysFromNow(day)
            notification.fireDate = futureDate
            let summary = KnockItOffPersistant.sharedInstance().summary()
            notification.alertBody = summary.timeQuitString
            notification.alertTitle = summary.timeQuitString
            notification.applicationIconBadgeNumber = 1;
            let localTimeDescription = futureDate.descriptionWithLocale(NSLocale.currentLocale())
            println("fireDate: " + localTimeDescription!)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    class func dateForDaysFromNow(daysfromNow: Int) -> NSDate {
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
}

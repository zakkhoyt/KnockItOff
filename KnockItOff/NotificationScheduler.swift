
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
        
        unscheduleNotifications()
        
        // Schedule daily notification for next 30 days
        for day in 1...30 {
            // schedule notification for tomorrow
            var notification = UILocalNotification()
            notification.timeZone = NSTimeZone.defaultTimeZone()
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
    
    class func unscheduleNotifications() {
        // Cancel all previously scheduled notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        println("Unscheduled all notifications")
    }
    
    class func dateForDaysFromNow(daysfromNow: Int) -> NSDate {
        
        let alarmDate = KnockItOffPersistant.sharedInstance().alarmTime()
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components((.HourCalendarUnit | .MinuteCalendarUnit), fromDate: alarmDate)
        let hour = comp.hour
        let minute = comp.minute
        
        let now = NSDate()
        let tomorrowComponents = NSDateComponents()
        tomorrowComponents.day = daysfromNow;
        
        
        
        let tomorrow = calendar.dateByAddingComponents(tomorrowComponents, toDate: now, options: nil)
        
        let tomorrowMorningComponents = calendar.components(.CalendarUnitEra | .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: tomorrow!)
        tomorrowMorningComponents.hour = hour
        tomorrowMorningComponents.minute = minute
        
        let tomorrowMorning = calendar.dateFromComponents(tomorrowMorningComponents)
        return tomorrowMorning!
    }
}

//
//  AppDelegate.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

enum NotificationStatus: Int {
    case NotPrompted = 0
    case Authorized = 1
    case Denied = 2
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var notificationStatus: NotificationStatus = .NotPrompted
    var window: UIWindow?
    
    private var notificationClosure:((NotificationStatus)->Void)! = nil

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
     
        let attr = [NSForegroundColorAttributeName: UIColor.yellowColor()]
        UINavigationBar.appearance().titleTextAttributes = attr
        UINavigationBar.appearance().barTintColor = UIColor.darkGrayColor()
        UINavigationBar.appearance().tintColor = UIColor.yellowColor()
        UIBarButtonItem.appearance().setTitleTextAttributes(attr, forState: UIControlState.Normal)
        
        UIToolbar.appearance().barTintColor = UIColor.darkGrayColor()
        UIToolbar.appearance().tintColor = UIColor.yellowColor()
        
        return true
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        println("did register user notifications")
        if notificationSettings.types == .None {
            notificationStatus = .Denied
        } else {
            notificationStatus = .Authorized
        }
        if notificationClosure != nil {
            notificationClosure(notificationStatus)
        }
    }

    func promptForNotifcations(notificationClosure: (NotificationStatus) -> (Void)) {
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        notificationStatus = .NotPrompted
        self.notificationClosure = notificationClosure
    }
}


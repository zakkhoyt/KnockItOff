//
//  CurrentStatusViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import AssetsLibrary

import KnockItOffKit

class CurrentStatusViewController: UIViewController {

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageStringLabel: UILabel!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBackgroundImage()
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
        
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
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
    
    func loadBackgroundImage(){
        let backgroundImageURL = VWWUserDefaults.sharedInstance().backgroungImageURL() as NSURL?
        if backgroundImageURL != nil {
            let library = ALAssetsLibrary()
            library.assetForURL(backgroundImageURL, resultBlock: { (asset) -> Void in
                let rep = asset.defaultRepresentation()
                let cgImage = rep.fullScreenImage().takeRetainedValue()
                let backgroundImage = UIImage(CGImage: cgImage)
                self.backgroundImageView.image = backgroundImage?
                if let url = backgroundImageURL?.absoluteString {
                    println("Setting background image to asset at url: %@" + url)
                }
                
                }, failureBlock: { (error) -> Void in
                    println("Failed to retrieve image from AssetLibrary")
            })
        }

    }
   
    @IBAction func cameraButtonAction(sender: AnyObject) {
        imagePicker.delegate = self;
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.allowsEditing = false
        presentViewController(imagePicker, animated: true) { () -> Void in
            
        }
    }
    
    
}

extension CurrentStatusViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        // Store image path for use next instance
        let assetURL = info[UIImagePickerControllerReferenceURL] as NSURL
        VWWUserDefaults.sharedInstance().setBackgroundImageURL(assetURL)
        
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.loadBackgroundImage()
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

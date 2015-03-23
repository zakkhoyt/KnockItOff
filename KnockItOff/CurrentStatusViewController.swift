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
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationWillEnterForegroundNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
            self.refreshUI()
        }
        
        refreshUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        NotificationScheduler.scheduleNotifications();
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshUI() {
        
        let summary = KnockItOffPersistant.sharedInstance().summary()
        
        let date = KnockItOffPersistant.sharedInstance().startDate()
        if date == nil {
            self.imageView.image = nil
            self.imageStringLabel.text = nil
            
            let attrString = NSMutableAttributedString()
            var insertPoint: Int = 0
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .Center
            
            let attr1 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.darkTextColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(32)]
            let str1 = NSString(format: "Tap settings to set up your scenario. Tap the camera to add a meaningful photo to help you.")
            attrString.appendAttributedString(NSAttributedString(string: str1))
            attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
            insertPoint += str1.length
            
            
            self.statusTextView.attributedText = attrString
        } else {
            
            self.imageView.image = KnockItOffPersistant.sharedInstance().imageForStartDate()
            self.imageStringLabel.text = KnockItOffPersistant.sharedInstance().imageStringForStartDate()
            self.imageStringLabel.textColor = KnockItOffPersistant.sharedInstance().imageStringColorForStartDate()
            
            let attrString = NSMutableAttributedString()
            var insertPoint: Int = 0
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .Center
            
            let attr1 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.darkTextColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(32)]
            
            let str1 = NSString(format: "%@ ", KnockItOffPersistant.sharedInstance().statusStringForStartDate())
            attrString.appendAttributedString(NSAttributedString(string: str1))
            attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
            insertPoint += str1.length
            
            let attr2 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.darkTextColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(24)]
            let str2 = NSString(format: "(%@)\n", KnockItOffPersistant.sharedInstance().startDateString())
            attrString.appendAttributedString(NSAttributedString(string: str2))
            attrString.setAttributes(attr2, range: NSMakeRange(insertPoint, str2.length))
            insertPoint += str2.length
            
            self.statusTextView.attributedText = attrString
        }
        
        
        loadBackgroundImage()
    }
    
    
    func loadBackgroundImage(){
        let backgroundImageURL = KnockItOffPersistant.sharedInstance().backgroungImageURL() as NSURL?
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
        KnockItOffPersistant.sharedInstance().setBackgroundImageURL(assetURL)
        
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.loadBackgroundImage()
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

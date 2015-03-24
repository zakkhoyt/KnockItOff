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

enum CurrentStatusTableViewSection: Int{
    case Status = 0
    case Reddit = 1
}

class CurrentStatusViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var posts: [RKLink] = []
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationWillEnterForegroundNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
            self.refreshUI()
        }
        reddit()
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
    
    func reddit(){
        //        RKClient.sharedClient().signInWithUsername("", password: "") { (error) -> Void in
        //            if error == nil {
        //                println("logged in")
        
        RKClient.sharedClient().subredditWithName("stopdrinking", completion: { (subreddit, error) -> Void in
            let pagination = RKPagination()
            RKClient.sharedClient().linksInSubreddit(subreddit as RKSubreddit, category: RKSubredditCategory.Top, pagination: pagination, completion: { (posts: [AnyObject]!, page: RKPagination!, error:NSError!) -> Void in
                //                    RKClient.sharedClient().linksInSubreddit(subreddit as RKSubreddit, pagination: pagination, completion: { (list: [AnyObject]!, page: RKPagination!, error:NSError!) -> Void in
                if error == nil {
                    
                    println("Got subreddit links")
                    
                    self.posts = posts as [RKLink]
                    var indexPaths: [NSIndexPath] = []
                    for index in 0..<posts.count {
                        let post = posts[index] as RKLink
                        let indexPath = NSIndexPath(forRow: index, inSection: CurrentStatusTableViewSection.Reddit.rawValue)
                        indexPaths.append(indexPath)
                        //                                    println("link: " + uLink.title + "\n\t" + uLink.URL!.absoluteString!)
                        println("link: " + post.title + "\n\t" + post.selfText!)
                    }
                    self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                } else {
                    println("could not get subreddit links")
                }
            })
        })
    }
    
    
    func refreshUI() {
        
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsetsMake(20.0, 0, 0, 0)
        //
        //        let summary = KnockItOffPersistant.sharedInstance().summary()
        //
        //        if summary == nil {
        //            self.imageView.image = nil
        //            self.imageStringLabel.text = nil
        //
        //            let attrString = NSMutableAttributedString()
        //            var insertPoint: Int = 0
        //            let paragraph = NSMutableParagraphStyle()
        //            paragraph.alignment = .Center
        //
        //            let attr1 = [NSParagraphStyleAttributeName : paragraph,
        //                NSForegroundColorAttributeName : UIColor.darkTextColor(),
        //                NSFontAttributeName: UIFont.systemFontOfSize(32)]
        //            let str1 = NSString(format: "Tap settings to set up your scenario. Tap the camera to add a meaningful photo to help you.")
        //            attrString.appendAttributedString(NSAttributedString(string: str1))
        //            attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
        //            insertPoint += str1.length
        //
        //
        //            self.statusTextView.attributedText = attrString
        //
        //        } else {
        //            if let i = summary.timeQuitImage {
        //                imageView.image = i
        //            }
        //
        //            if let i = summary.timeQuitString {
        //                imageStringLabel.text = i
        //            }
        //
        //            if let i = summary.timeQuitStringColor {
        //                imageStringLabel.textColor = i
        //            }
        //
        //
        //            imageStringLabel.sizeToFit()
        //
        //            let attrString = NSMutableAttributedString()
        //            var insertPoint: Int = 0
        //            let paragraph = NSMutableParagraphStyle()
        //            paragraph.alignment = .Center
        //
        //            let attr1 = [NSParagraphStyleAttributeName : paragraph,
        //                NSForegroundColorAttributeName : UIColor.darkTextColor(),
        //                NSFontAttributeName: UIFont.systemFontOfSize(32)]
        //
        //            let str1 = NSString(format: "%@ ", summary.daysQuitString)
        //            attrString.appendAttributedString(NSAttributedString(string: str1))
        //            attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
        //            insertPoint += str1.length
        //
        //            let attr2 = [NSParagraphStyleAttributeName : paragraph,
        //                NSForegroundColorAttributeName : UIColor.darkTextColor(),
        //                NSFontAttributeName: UIFont.systemFontOfSize(24)]
        //            let str2 = NSString(format: "(%@)", summary.startDateString)
        //            attrString.appendAttributedString(NSAttributedString(string: str2))
        //            attrString.setAttributes(attr2, range: NSMakeRange(insertPoint, str2.length))
        //            insertPoint += str2.length
        //
        //            let attr3 = [NSParagraphStyleAttributeName : paragraph,
        //                NSForegroundColorAttributeName : UIColor.blackColor(),
        //                NSFontAttributeName: UIFont.systemFontOfSize(24)]
        //            let str3 = NSString(format: "\n\n\nYou've saved yourself:\n%lu beers\n$%lu\n%ld calories\n",
        //                summary.beersSaved.unsignedIntegerValue,
        //                summary.moneySaved.unsignedIntegerValue,
        //                summary.caloriesSaved.unsignedIntegerValue)
        //            attrString.appendAttributedString(NSAttributedString(string: str3))
        //            attrString.setAttributes(attr3, range: NSMakeRange(insertPoint, str3.length))
        //            insertPoint += str3.length
        //
        //
        //            statusTextView.attributedText = attrString
        //
        //        }
        
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

extension CurrentStatusViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case CurrentStatusTableViewSection.Status.rawValue:
            return 3
        case CurrentStatusTableViewSection.Reddit.rawValue:
            return posts.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case CurrentStatusTableViewSection.Status.rawValue:
            let summary = KnockItOffPersistant.sharedInstance().summary()
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("TimeQuitImageTableViewCell") as TimeQuitImageTableViewCell
                cell.summary = summary
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("DaysQuitStringTableViewCell") as DaysQuitStringTableViewCell
                cell.summary = summary
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("SavingsTableViewCell") as SavingsTableViewCell
                cell.summary = summary
                return cell
            default:
                return UITableViewCell()
            }
        case CurrentStatusTableViewSection.Reddit.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("RedditPostTableViewCell") as RedditPostTableViewCell
            cell.post = posts[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
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

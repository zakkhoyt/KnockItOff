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
    let refreshControl = UIRefreshControl()
    let imagePicker = UIImagePickerController()
    let SegueMainToPost = "SegueMainToPost"
    let SegueMainToChat = "SegueMainToChat"
    
    var posts: [RKLink] = []
    var lastContentOffset: CGPoint = CGPointZero
    var statusBarHidden = false
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationWillEnterForegroundNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
            self.refreshUI(self.refreshControl)
            self.refreshApplicationBadge()
        }
        
        refreshControl.addTarget(self, action: "refreshUI:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        refreshUI(refreshControl)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.sharedApplication().statusBarHidden = statusBarHidden
        
        if KnockItOffPersistant.sharedInstance().localNotifications() == true {
            let alarmTime = KnockItOffPersistant.sharedInstance().alarmTime()
            if alarmTime != nil {
                NotificationScheduler.scheduleNotifications();
            }
        } else {
            NotificationScheduler.unscheduleNotifications();
        }
        
        refreshApplicationBadge()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueMainToPost {
            let nc = segue.destinationViewController as! UINavigationController
            let vc = nc.viewControllers[0] as! RedditPostViewController
            vc.post = sender as? RKLink
        } else if segue.identifier == SegueMainToChat {
            let nc = segue.destinationViewController as! UINavigationController
            let vc = nc.viewControllers[0] as! WebViewController
            vc.url = sender as? NSURL
        }
    }
    
    func refreshApplicationBadge() {
        let summary = KnockItOffPersistant.sharedInstance().summary()
        UIApplication.sharedApplication().applicationIconBadgeNumber = summary.daysQuit.unsignedIntegerValue
    }
    
    @IBAction func chatButtonTouchUpInside(sender: AnyObject) {
        let ac = UIAlertController(title: "Chat with someone", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        ac.addAction(UIAlertAction(title: "/r/stopdrinking main chat", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let url = NSURL(string: "https://kiwiirc.com/client/irc.snoonet.org/stopdrinking/")
            self.performSegueWithIdentifier(self.SegueMainToChat, sender: url)
        }))
        
        ac.addAction(UIAlertAction(title: "/r/stopdrinking alternate chat", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let url = NSURL(string: "http://client00.chat.mibbit.com/?server=irc.snoonet.org&channel=%23stopdrinking")
            self.performSegueWithIdentifier(self.SegueMainToChat, sender: url)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:nil))
        
        presentViewController(ac, animated: true) { () -> Void in
            
        }
    }
    
    func reddit(){
        RKClient.sharedClient().subredditWithName("stopdrinking", completion: { (subreddit, error) -> Void in
            let pagination = RKPagination()
            RKClient.sharedClient().linksInSubreddit(subreddit as! RKSubreddit, category: RKSubredditCategory.Top, pagination: pagination, completion: { (posts: [AnyObject]!, page: RKPagination!, error:NSError!) -> Void in
                if error == nil {
                    
                    if self.posts.count == 0 {
                        self.posts = posts as! [RKLink]
                        var indexPaths: [NSIndexPath] = []
                        for index in 0..<posts.count {
                            let post = posts[index] as! RKLink
                            let indexPath = NSIndexPath(forRow: index, inSection: CurrentStatusTableViewSection.Reddit.rawValue)
                            indexPaths.append(indexPath)
                        }
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                    } else {
                        self.tableView.reloadData()
                    }
                } else {
                    println("could not get subreddit links")
                }
            })
        })
    }
    
    
    func refreshUI(sender: UIRefreshControl) {
        sender.endRefreshing()
        reddit()
        loadBackgroundImage()

    }
    
    
    func loadBackgroundImage(){
        let backgroundImageURL = KnockItOffPersistant.sharedInstance().backgroungImageURL() as NSURL?
        if backgroundImageURL != nil {
            let library = ALAssetsLibrary()
            library.assetForURL(backgroundImageURL, resultBlock: { (asset) -> Void in
                let rep = asset.defaultRepresentation()
                let cgImage = rep.fullScreenImage().takeUnretainedValue()
                let backgroundImage = UIImage(CGImage: cgImage)
                self.backgroundImageView.image = backgroundImage
                if let url = backgroundImageURL?.absoluteString {
                    println("Setting background image to asset at url: %@" + url)
                }
                
                }, failureBlock: { (error) -> Void in
                    println("Failed to retrieve image from AssetLibrary")
            })
        } else {
            self.backgroundImageView.image = UIImage(named: "background")
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

extension CurrentStatusViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 100 {
            showNavBar()
        } else {
            hideNavBar()
        }
    }
    
    func showNavBar() {
        if statusBarHidden == false {
            return
        }
        statusBarHidden = false
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.toolbar.alpha = 1.0
        })
    }
    func hideNavBar() {
        if statusBarHidden == true {
            return
        }
        statusBarHidden = true
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.toolbar.alpha = 0.0
        })
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
                let cell = tableView.dequeueReusableCellWithIdentifier("TimeQuitImageTableViewCell") as! TimeQuitImageTableViewCell
                cell.summary = summary
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("DaysQuitStringTableViewCell") as! DaysQuitStringTableViewCell
                cell.summary = summary
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("SavingsTableViewCell") as! SavingsTableViewCell
                cell.summary = summary
                return cell
            default:
                return UITableViewCell()
            }
        case CurrentStatusTableViewSection.Reddit.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("RedditPostTableViewCell") as! RedditPostTableViewCell
            cell.post = posts[indexPath.row]
            cell.index = UInt(indexPath.row)
            //            println("indexPath: \(indexPath.row)")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == CurrentStatusTableViewSection.Reddit.rawValue {
            if posts.count > 0 {
                return 0
            } else {
                return 44.0
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRectMake(0, 0, view.bounds.width, 44)
        let headerView = UIView(frame: frame)
        headerView.backgroundColor = UIColor.clearColor()
        let activityView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 44, 44))
        activityView.startAnimating()
        activityView.activityIndicatorViewStyle = .WhiteLarge
        activityView.color = UIColor.darkGrayColor()
        activityView.center = headerView.center
        headerView.addSubview(activityView)
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(__FUNCTION__)
        let post = posts[indexPath.row]
        self.performSegueWithIdentifier(self.SegueMainToPost, sender: post)
    }
}

extension CurrentStatusViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        // Store image path for use next instance
        let assetURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        KnockItOffPersistant.sharedInstance().setBackgroundImageURL(assetURL)
        
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.loadBackgroundImage()
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


extension CurrentStatusViewController: UIToolbarDelegate {
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
}
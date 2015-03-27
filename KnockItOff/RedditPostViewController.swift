//
//  RedditPostViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/24/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

enum RedditPostViewControllerTableViewSection: Int {
    case Post = 0
    case Comments = 1
}

class RedditPostViewController: UIViewController {

    @IBOutlet weak var treeView: RATreeView!
    var post: RKLink? = nil
    var comments: [RKComment]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        treeView.dataSource = self;
        treeView.delegate = self;
        treeView.separatorStyle = RATreeViewCellSeparatorStyleNone

        MBProgressHUD.showHUDAddedTo(view, animated: true)
        RKClient.sharedClient().commentsForLink(post, completion: { (comments, pagination, error) -> Void in
            if error == nil {
                for index in 0..<comments.count {
                    let comment = comments[index] as RKComment
                    println("\(index): comment.replics \(comment.replies.count)")
                }
                self.comments = comments as? [RKComment]
                self.treeView.reloadData()
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}


extension RedditPostViewController: RATreeViewDataSource{
    
    func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {
        let cell = NSBundle.mainBundle().loadNibNamed("CommentTableViewCell", owner: self, options: nil)[0] as? CommentTableViewCell
        if let comment = item as RKComment? {
            cell?.comment = comment
        }
        cell?.level = treeView.levelForCellForItem(item)
        return cell
    }
    
    func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
        if item == nil {
            if let c = comments? {
                return c.count
            } else {
                return 0
            }
        }
        
        let comment = item as RKComment
        return comment.replies.count
    }
    
    func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {
        let comment = item as RKComment?
        if item == nil {
            return comments![index]
        }
        return comment!.replies[index]
    }
}

extension RedditPostViewController: RATreeViewDelegate {

    
    func treeView(treeView: RATreeView!, willExpandRowForItem item: AnyObject!) {
        let cell = treeView.cellForItem(item) as CommentTableViewCell
        cell.expanded = true
    }
    
    func treeView(treeView: RATreeView!, willCollapseRowForItem item: AnyObject!) {
        let cell = treeView.cellForItem(item) as CommentTableViewCell
        cell.expanded = false
    }
//    func treeView(treeView: RATreeView!, indentationLevelForRowForItem item: AnyObject!) -> Int {
//        
//    }
    
//    func treeView(treeView: RATreeView!, didSelectRowForItem item: AnyObject!) {
//        let comment = item as RKComment?
//        println("comment: " + comment!.body)
//        println("this comment has \(comment!.replies.count) replies")
//        
//        
//        if treeView.isCellForItemExpanded(item) {
//            treeView.collapseRowForItem(item, collapseChildren: true, withRowAnimation: RATreeViewRowAnimationAutomatic)
//        } else {
//            treeView.expandRowForItem(item, expandChildren: true, withRowAnimation: RATreeViewRowAnimationAutomatic)
//        }
//    }
//    
//    func treeView(treeView: RATreeView!, shouldExpandRowForItem item: AnyObject!) -> Bool {
//        return true
//    }
//    
//    func treeView(treeView: RATreeView!, shouldCollapaseRowForItem item: AnyObject!) -> Bool {
//        return true
//    }
}

//
//extension RedditPostViewController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else if section == 1 {
//            if let c = comments? {
//                return c.count
//            } else {
//                return 0
//            }
//        }
//        
//        return 0
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case RedditPostViewControllerTableViewSection.Post.rawValue:
//            let cell = tableView.dequeueReusableCellWithIdentifier("PostDetailsTableViewCell") as PostDetailsTableViewCell
//            cell.post = post
//            return cell
//        case RedditPostViewControllerTableViewSection.Comments.rawValue:
//            let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as CommentTableViewCell
//            cell.comment = comments?[indexPath.row]
//            return cell
//        default:
//            return UITableViewCell()
//        }
//    }
//}


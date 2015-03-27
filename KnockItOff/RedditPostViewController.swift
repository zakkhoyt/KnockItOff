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
        if item.isKindOfClass(RKComment) {
            let cell = NSBundle.mainBundle().loadNibNamed("CommentTableViewCell", owner: self, options: nil)[0] as? CommentTableViewCell
            if let comment = item as RKComment? {
                cell?.comment = comment
            }
            cell?.level = treeView.levelForCellForItem(item)
            return cell
            
        } else if item.isKindOfClass(RKLink) {
            let cell = NSBundle.mainBundle().loadNibNamed("PostDetailsTableViewCell", owner: self, options: nil)[0] as? PostDetailsTableViewCell
            if let post = item as RKLink? {
                cell?.post = post
            }
            return cell
            
        }
        
        return UITableViewCell()
//        let cell = NSBundle.mainBundle().loadNibNamed("CommentTableViewCell", owner: self, options: nil)[0] as? CommentTableViewCell
//        if let comment = item as RKComment? {
//            cell?.comment = comment
//        }
//        cell?.level = treeView.levelForCellForItem(item)
//        return cell
    }
    
    func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
        if item == nil {
            if let c = comments? {
                return c.count + 1
            } else {
                return 1
            }
        }
        
        let comment = item as RKComment
        return comment.replies.count
//        if item == nil {
//            if let c = comments? {
//                return c.count + 0
//            } else {
//                return 0
//            }
//        }
//        
//        let comment = item as RKComment
//        return comment.replies.count

    }
    
    func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {
        
        
        if item == nil {
            if index == 0 {
                return post
            } else {
                return comments![index-1]
            }
        } else {
            let comment = item as RKComment?
            return comment!.replies[index-1]
        }
        
//        if let comment = item as RKComment? {
//          return comment.replies[index]
//        } else if let post = item as RKLink? {
//            return post
//        } else {
//            return comments![index]
//        }
        
//        let comment = item as RKComment?
//        if item == nil {
//            return comments![index]
//        }
//        return comment!.replies[index]
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
}

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

    @IBOutlet weak var tableView: UITableView!
    var post: RKLink? = nil
    var comments: [RKComment]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension

        RKClient.sharedClient().commentsForLink(post, completion: { (comments, pagination, error) -> Void in
            if error == nil {
                for index in 0..<comments.count {
                    let comment = comments[index] as RKComment
                    println("\(index): comment.replics \(comment.replies.count)")
                }
                self.comments = comments as? [RKComment]
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}

extension RedditPostViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if let c = comments? {
                return c.count
            } else {
                return 0
            }
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case RedditPostViewControllerTableViewSection.Post.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("PostDetailsTableViewCell") as PostDetailsTableViewCell
            cell.post = post
            return cell
        case RedditPostViewControllerTableViewSection.Comments.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as CommentTableViewCell
            cell.comment = comments?[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
}


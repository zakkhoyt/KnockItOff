//
//  HelpTableViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class HelpTableViewController: UITableViewController {

    let SegueHelpToWeb = "SegueHelpToWeb"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueHelpToWeb {
            let vc = segue.destinationViewController as WebViewController
            let url = sender as? NSURL
            vc.url = url
        }
    }

    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            performSegueWithIdentifier(SegueHelpToWeb, sender: NSURL(string: "http://reddit.com/r/stopdrinking"))
        } else if indexPath.row == 1 {
            performSegueWithIdentifier(SegueHelpToWeb, sender: NSURL(string: "https://kiwiirc.com/client/irc.snoonet.org/stopdrinking/"))
        } else if indexPath.row == 2 {
            performSegueWithIdentifier(SegueHelpToWeb, sender: NSURL(string: "http://client00.chat.mibbit.com/?server=irc.snoonet.org&channel=%23stopdrinking"))
        }
        
    }
}

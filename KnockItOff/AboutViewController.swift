//
//  AboutViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/26/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}


extension AboutViewController: UINavigationBarDelegate{
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
}
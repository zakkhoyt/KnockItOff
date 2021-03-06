//
//  WebViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var url: NSURL? = nil
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if url == nil {
            return
        }
        
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        webView.scalesPageToFit = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

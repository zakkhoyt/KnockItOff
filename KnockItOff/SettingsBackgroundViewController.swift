//
//  SettingsBackgroundViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/31/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit
import AssetsLibrary

class SettingsBackgroundViewController: UIViewController {
    
    let library = ALAssetsLibrary()
    @IBOutlet weak var promptButton: UIButton!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.hidden = true;
        
        let status: ALAuthorizationStatus = ALAssetsLibrary.authorizationStatus()
        
        switch status{
        case .NotDetermined:
            self.chooseButton.hidden = true
            self.promptButton.hidden = false
            self.errorLabel.hidden = true
            self.nextButton.hidden = false
        case .Restricted:
            self.chooseButton.hidden = true
            self.promptButton.hidden = true
            self.errorLabel.hidden = false
            self.nextButton.hidden = false
        case .Denied:
            self.chooseButton.hidden = true
            self.promptButton.hidden = true
            self.errorLabel.hidden = false
            self.nextButton.hidden = false
        case .Authorized:
            self.chooseButton.hidden = false
            self.promptButton.hidden = true
            self.errorLabel.hidden = true
            self.nextButton.hidden = false
        }
        
    }
    
    
    @IBAction func promptButtonTouchUpinside(sender: AnyObject) {
        library.enumerateGroupsWithTypes(ALAssetsGroupSavedPhotos, usingBlock: { (group, stop) -> Void in
            self.chooseButton.hidden = false
            self.promptButton.hidden = true
            self.errorLabel.hidden = true
            
            }, failureBlock: { (error) -> Void in
                self.chooseButton.hidden = true
                self.promptButton.hidden = true
                self.errorLabel.hidden = false
        })
    }
    
    
    @IBAction func choosePhotoButtonTouchUpInside(sender: AnyObject) {
    }
    
    @IBAction func nextButtonTouchUpInsde(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("CurrentStatusViewController") as! CurrentStatusViewController
        presentViewController(vc, animated: true) { () -> Void in
            
        }
    }
}

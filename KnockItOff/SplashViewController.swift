//
//  SplashViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/27/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {

    @IBOutlet weak var yalLabel: YALLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.sharedApplication().statusBarHidden = true
        
        view.backgroundColor = UIColor.darkGrayColor()
        yalLabel.backgroundColor = UIColor.clearColor()
        yalLabel.text = "/r/stopDrinking"
        yalLabel.fontName = "AmericanTypewriter-Bold"
        //    self.yalLabel.fontName = @"Avenir-BlackOblique";
        //    self.yalLabel.fontName = @"Futura-CondensedExtraBold";
        //    self.yalLabel.fontName = @"HelveticaNeue-UltraLight";
        //    self.yalLabel.fontName = @"Optima-Bold";
        yalLabel.fontSize = 40.0
        yalLabel.fillColor = UIColor.yellowColor()
        yalLabel.backgroundFillColor = UIColor.blackColor()
        yalLabel.strokeColor = UIColor.lightGrayColor()
        yalLabel.strokeWidth = 1.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let sublayers: NSArray = yalLabel.fillLayer.sublayers
        sublayers.enumerateObjectsUsingBlock { (sublayer, index, stop) -> Void in
            let fillAnimation = YALPathFillAnimation(path: self.yalLabel.fillLayer.mask.path, andDirectionAngle: 0)
            fillAnimation.delegate = self
            fillAnimation.duration = 3.0
            sublayer.mask?.addAnimation(fillAnimation, forKey: "fillAnimation")
        }
    }

}


extension SplashViewController {
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateInitialViewController() as UIViewController
        vc.modalTransitionStyle = .CrossDissolve
        presentViewController(vc, animated: true) { () -> Void in
            
        }
    }
}

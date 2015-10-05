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
    @IBOutlet weak var descriptionLabel: YALLabel!
    var splashed: Bool = false
    
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
        yalLabel.fillColor = UIColor.blackColor()
        yalLabel.backgroundFillColor = UIColor.yellowColor()
        yalLabel.strokeColor = UIColor.lightGrayColor()
        yalLabel.strokeWidth = 1.0
        
        
        descriptionLabel.backgroundColor = UIColor.clearColor()
        descriptionLabel.text = "Stop drinking alcohol."
        descriptionLabel.fontName = "AmericanTypewriter-Bold"

        //    self.yalLabel.fontName = @"Avenir-BlackOblique";
        //    self.yalLabel.fontName = @"Futura-CondensedExtraBold";
        //    self.yalLabel.fontName = @"HelveticaNeue-UltraLight";
        //    self.yalLabel.fontName = @"Optima-Bold";
        descriptionLabel.fontSize = 20.0
        descriptionLabel.fillColor = UIColor.blackColor()
        descriptionLabel.backgroundFillColor = UIColor.yellowColor()
        descriptionLabel.strokeColor = UIColor.lightGrayColor()
        descriptionLabel.strokeWidth = 1.0

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let sublayers: NSArray = yalLabel.fillLayer!.sublayers!
        sublayers.enumerateObjectsUsingBlock { (sublayer, index, stop) -> Void in
            if index % 2 == 0 {
                let fillAnimation = YALPathFillAnimation(path: self.yalLabel.fillLayer!.mask.path, andDirectionAngle: 180)
                fillAnimation.duration = 4.0
                sublayer.mask?!.addAnimation(fillAnimation, forKey: "fillAnimation_even")
            } else {
                let fillAnimation = YALPathFillAnimation(path: self.yalLabel.fillLayer!.mask.path, andDirectionAngle: 180)
                fillAnimation.duration = 4.0
                sublayer.mask?!.addAnimation(fillAnimation, forKey: "fillAnimation_odd")

            }
        }
        
        
        let dSublayers: NSArray = descriptionLabel.fillLayer!.sublayers!
        dSublayers.enumerateObjectsUsingBlock { (sublayer, index, stop) -> Void in
            let fillAnimation = YALPathFillAnimation(path: self.yalLabel.fillLayer!.mask.path, andDirectionAngle: 180)
            fillAnimation.duration = 2.0
            sublayer.mask?!.addAnimation(fillAnimation, forKey: "fillAnimation_tiny")
        }
    
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, 5 * Int64(NSEC_PER_SEC))
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc = storyboard.instantiateInitialViewController() as UIViewController?
            vc!.modalTransitionStyle = .CrossDissolve
            self.presentViewController(vc!, animated: true) { () -> Void in
            }
        }
    }
}


//extension SplashViewController {
//    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
//        if splashed == false {
//            splashed = true
//            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            let vc = storyboard.instantiateInitialViewController() as UIViewController
//            vc.modalTransitionStyle = .CrossDissolve
//            presentViewController(vc, animated: true) { () -> Void in
//            }
//        }
//    }
//}

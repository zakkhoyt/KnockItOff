//
//  AboutViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/26/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var yalLabel: YALLabel!
    @IBOutlet weak var textView: UITextView!
    var emitterLayer: CAEmitterLayer = CAEmitterLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        yalLabel.backgroundColor = UIColor.clearColor()
        yalLabel.text = "/r/stopDrinking"
        yalLabel.fontName = "AmericanTypewriter-Bold"
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
            if index % 2 == 0 {
                let fillAnimation = YALPathFillAnimation(path: self.yalLabel.fillLayer.mask.path, andDirectionAngle: 0)
                fillAnimation.duration = 3.0
                sublayer.mask?.addAnimation(fillAnimation, forKey: "fillAnimation_even")
            } else {
                let fillAnimation = YALPathFillAnimation(path: self.yalLabel.fillLayer.mask.path, andDirectionAngle: 180)
                fillAnimation.duration = 3.0
                sublayer.mask?.addAnimation(fillAnimation, forKey: "fillAnimation_odd")
            }
        }
    }
}


extension AboutViewController: UINavigationBarDelegate{
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
}
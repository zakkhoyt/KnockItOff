//
//  SettingsCostViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/31/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class SettingsCostViewController: UIViewController {

    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var beveragesLabel: UILabel!
    @IBOutlet weak var beveragesStepper: UIStepper!
    @IBOutlet weak var priceStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func viewWillAppear(animated: Bool) {
        var p: UInt = KnockItOffPersistant.sharedInstance().pricePerDay()
        priceStepper?.value = Double(p)
        let f: Float = Float(p) / 100.0
        costLabel?.text = NSString(format: "$%.2f spent daily", f) as String
        
        let b = KnockItOffPersistant.sharedInstance().beveragesPerDay()
        beveragesStepper?.value = Double(b)
        beveragesLabel?.text = NSString(format: "%lu beverages daily", b) as String
        
    }
    
    
    @IBAction func priceStepperValueChanged(sender: UIStepper) {
        let f: Float = Float(sender.value);
        costLabel?.text = NSString(format: "$%.2f spent daily", f / 100) as String
        KnockItOffPersistant.sharedInstance().setPricePerDay(UInt(f))
    }

    @IBAction func beveragesStepperValueChanged(sender: UIStepper) {
        let b = UInt(sender.value)
        beveragesLabel?.text = NSString(format: "%lu beverages daily", b) as String
        KnockItOffPersistant.sharedInstance().setBeveragesPerDay(b)
    }

}

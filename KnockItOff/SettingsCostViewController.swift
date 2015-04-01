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
        
        let p: UInt = KnockItOffPersistant.sharedInstance().pricePerDay()
        priceStepper?.value = Double(p)
        costLabel?.text = NSString(format: "%.2f spent daily", p / 100.0)

        let b = KnockItOffPersistant.sharedInstance().beveragesPerDay()
        beveragesStepper?.value = Double(b)
        beveragesLabel?.text = NSString(format: "%lu beverages daily", b)
    }

    
    
    @IBAction func priceStepperValueChanged(sender: UIStepper) {
        let f: Float = Float(sender.value);
        costLabel?.text = NSString(format: "%.2f spent daily", f / 100)
        KnockItOffPersistant.sharedInstance().setPricePerDay(UInt(f))
    }

    @IBAction func beveragesStepperValueChanged(sender: UIStepper) {
        beveragesLabel?.text = NSString(format: "%lu beverages daily", sender.value)
        KnockItOffPersistant.sharedInstance().setBeveragesPerDay(UInt(sender.value))
    }

}

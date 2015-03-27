//
//  TimePickerTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/27/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class TimePickerTableViewCell: UITableViewCell {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var picker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func setButtonTouchUpInside(sender: UIButton) {
        if self.heightConstraint!.constant == 0 {
            self.heightConstraint!.constant = 162
        } else {
            self.heightConstraint!.constant = 0
        }
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.layoutIfNeeded()
        })
    }

}

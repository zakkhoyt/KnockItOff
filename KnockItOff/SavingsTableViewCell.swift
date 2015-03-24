//
//  SavingsTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class SavingsTableViewCell: UITableViewCell {

    
    var summary: Summary? = nil{
        didSet{
            let attrString = NSMutableAttributedString()
            var insertPoint: Int = 0
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .Center
            
            let attr1 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.blackColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(24)]
            let str1 = NSString(format: "\nBy not drinking you've saved yourself:\nGuzzling %lu beers/drinks\nSpending $%lu\nConsuming %ld calories\n",
                summary!.beersSaved.unsignedIntegerValue,
                summary!.moneySaved.unsignedIntegerValue,
                summary!.caloriesSaved.unsignedIntegerValue)
            attrString.appendAttributedString(NSAttributedString(string: str1))
            attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
            insertPoint += str1.length

            statusLabel.attributedText = attrString
        }
    }
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

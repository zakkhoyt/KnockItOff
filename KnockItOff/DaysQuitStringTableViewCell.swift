//
//  DaysQuitStringTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class DaysQuitStringTableViewCell: UITableViewCell {

//    var daysQuitString: NSAttributedString? = nil {
//        didSet{
//            statusLabel.attributedText = daysQuitString
//        }
//    }
    
    var summary: Summary? = nil{
        didSet{
            let attrString = NSMutableAttributedString()
            var insertPoint: Int = 0
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .Center
            
            let attr1 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.darkTextColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(32)]
            
            let str1 = NSString(format: "\n%@ ", summary!.daysQuitString)
            attrString.appendAttributedString(NSAttributedString(string: str1))
            attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
            insertPoint += str1.length
            
            let attr2 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.darkTextColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(24)]
            let str2 = NSString(format: "(%@)\n", summary!.startDateString)
            attrString.appendAttributedString(NSAttributedString(string: str2))
            attrString.setAttributes(attr2, range: NSMakeRange(insertPoint, str2.length))
            insertPoint += str2.length

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

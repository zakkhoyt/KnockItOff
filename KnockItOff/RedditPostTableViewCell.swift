//
//  RedditPostTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class RedditPostTableViewCell: UITableViewCell {


    
    @IBOutlet weak var postTextView: UITextView!
    
    var post: RKLink? = nil{
        didSet{
            let attrString = NSMutableAttributedString()
            var insertPoint: Int = 0
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .Left
            
            let attr1 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.blackColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(18)]
            
            let str1 = NSString(format: "%@\n\n", post!.title)
            attrString.appendAttributedString(NSAttributedString(string: str1))
            attrString.setAttributes(attr1, range: NSMakeRange(insertPoint, str1.length))
            insertPoint += str1.length
            
            let attr2 = [NSParagraphStyleAttributeName : paragraph,
                NSForegroundColorAttributeName : UIColor.darkTextColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(15)]
            let str2 = NSString(format: "%@\n", post!.selfText)
            attrString.appendAttributedString(NSAttributedString(string: str2))
            attrString.setAttributes(attr2, range: NSMakeRange(insertPoint, str2.length))
            insertPoint += str2.length

            postTextView.attributedText = attrString
            postTextView.sizeToFit()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

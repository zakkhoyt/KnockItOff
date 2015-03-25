//
//  CommentTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/24/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var repliesLabel: UILabel!
    
    @IBOutlet weak var indentConstrint: NSLayoutConstraint!
    var level: Int = 0{
        didSet{
            indentConstrint.constant = CGFloat(level) * 16
        }
    }
    
    var comment: RKComment? = nil {
        didSet{
            commentTextView.text = comment?.body
            let replies = comment?.replies as NSArray?
            repliesLabel.text = NSString(format: "%lu", replies!.count)
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

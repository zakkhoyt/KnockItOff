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
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!

    
    @IBOutlet weak var indentConstrint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var level: Int = 0{
        didSet{
            indentConstrint.constant = 30 + CGFloat(level-1) * 16
            
        }
    }
    
    var comment: RKComment? = nil {
        didSet{
            commentTextView.text = comment?.body
            userLabel.text = NSString(format: "▼ %@", comment!.author)
            votesLabel.text = NSString(format: "+%lu", comment!.score)
            
//            ▶︎
//            ▲
//            ▼
//            
//            ▶️
//
//            🔼
//            🔽
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

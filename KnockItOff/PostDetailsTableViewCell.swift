//
//  PostDetailsTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/24/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class PostDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var bodyTextView: UITextView!
    
    var post: RKLink? = nil {
        didSet{
            bodyTextView.text = post?.selfText
            // totalComments
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

//
//  TimeQuitImageTableViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit


class TimeQuitImageTableViewCell: UITableViewCell {

    @IBOutlet weak var timeQuitmageView: UIImageView!
    @IBOutlet weak var timeQuitStringLabel: UILabel!

    
    var summary: Summary? = nil{
        didSet{
            if let i = summary?.timeQuitImage {
                timeQuitmageView.image = i
            }
            
            if let i = summary?.timeQuitString {
                timeQuitStringLabel.text = i
                timeQuitStringLabel.textColor = summary?.timeQuitStringColor
            }
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

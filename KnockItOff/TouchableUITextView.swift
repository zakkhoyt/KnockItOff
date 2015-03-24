//
//  TouchableUITextView.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit


protocol TouchableUITextViewDelegate{
    func touchesEnded()
    
}

class TouchableUITextView: UITextView {
    
    var touchDelegate: TouchableUITextViewDelegate? = nil
    

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        touchDelegate?.touchesEnded()
    }
}

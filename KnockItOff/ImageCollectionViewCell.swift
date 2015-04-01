//
//  ImageCollectionViewCell.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/31/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    let ImageCollectionViewCellKey = "ImageCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

//
//  SettingsTodayViewController.swift
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/31/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

import UIKit



class SettingsTodayViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let ImageCollectionViewCellKey = "ImageCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: ImageCollectionViewCellKey, bundle:nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier:  ImageCollectionViewCellKey)
        collectionView?.backgroundColor = UIColor.clearColor()
    }
}


extension SettingsTodayViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCellKey, forIndexPath: indexPath) as! ImageCollectionViewCell
        let imageName = NSString(format: "today_%1", indexPath.item)
        cell.imageView.image = UIImage(named: imageName as String)
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
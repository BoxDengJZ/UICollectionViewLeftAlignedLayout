//
//  RightAlignedViewController.swift
//  fuchou
//
//  Created by Jz D on 2019/5/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit

class RightAlignedViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCell.self , forCellWithReuseIdentifier: CollectionViewCell.CellID)
        if let animatedCollectionView = collectionView{
            Timer.scheduledTimer(timeInterval: 6.0, target: animatedCollectionView, selector: #selector(UICollectionView.reloadData), userInfo: nil, repeats: true)
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       // return 2
        
        
        return section == 0 ? 20 :80
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.CellID, for: indexPath) as! CollectionViewCell
        cell.config("\(indexPath.item)")
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let  randomWidth = (arc4random() % 120) + 60;
        return CGSize(width: CGFloat(randomWidth), height: 60);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 15 :5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
}


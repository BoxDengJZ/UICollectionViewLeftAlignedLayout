//
//  HistoTitleV.swift
//  petit
//
//  Created by Jz D on 2020/10/27.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit

class HistoTitleV: UICollectionReusableView {

    
    
    @IBOutlet weak var bg: UIView!
    
    
    
    @IBOutlet weak var avatar: UIImageView!
    
    
    
    @IBOutlet weak var up: UILabel!
    
    
    
    @IBOutlet weak var down: UILabel!
    
    
    
    
    func title(name above: String, press below: String){
        up.text = above
        down.text = below
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        bg.backgroundColor = .cloak
    }
    
}

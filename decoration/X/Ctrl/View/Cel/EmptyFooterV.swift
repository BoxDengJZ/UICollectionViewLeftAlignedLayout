//
//  EmptyFooterV.swift
//  petit
//
//  Created by Jz D on 2020/10/27.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit

class EmptyFooterV: UICollectionReusableView {
    
    
    
    @IBOutlet weak var bg: UIView!
    
    
    
    func decorateHis(){
        bg.backgroundColor = .cloak
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

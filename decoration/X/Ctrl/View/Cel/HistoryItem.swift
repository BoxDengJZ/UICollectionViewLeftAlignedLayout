//
//  HistoryItem.swift
//  petit
//
//  Created by Jz D on 2020/10/27.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit

class HistoryItem: UICollectionViewCell {
    
    
    @IBOutlet weak var lhs: UILabel!
    
    
    
    @IBOutlet weak var rhs: UILabel!
    
    
    
    
    func title(name left: String, time right: String){
        lhs.text = left
        rhs.text = right
        
    }
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//
//  TitleLabel.swift
//  fuchou
//
//  Created by Jz D on 2019/5/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    func setup(){
        textColor = UIColor.flatPeterRiver
        font = UIFont.systemFont(ofSize: 25)
        textAlignment = .center
    }

}

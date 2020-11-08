//
//  HistoDecorationV.swift
//  petit
//
//  Created by Jz D on 2020/10/27.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit

class HistoDecorationV: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white

        corner(8)
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let edge: CGFloat = 6
        let f = bounds.insetBy(dx: edge, dy: edge)
        layer.shadowPath = UIBezierPath(rect: f).cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 视图， 从 nib 中初始化
    }
}

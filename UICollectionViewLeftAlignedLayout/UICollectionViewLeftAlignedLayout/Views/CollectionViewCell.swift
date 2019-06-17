//
//  CollectionViewCell.swift
//  fuchou
//
//  Created by Jz D on 2019/5/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let label: UILabel = {
        let text = UILabel(frame: CGRect.zero)
        text.clipsToBounds = true
        text.textAlignment = .center
        text.textColor = UIColor.black
        text.layer.borderColor = UIColor.flatPeterRiver.cgColor
        text.layer.borderWidth = 2;
        return text
    }()
    
    static let CellID = "kCellIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let side: CGFloat = 40
        label.layer.cornerRadius = side/2
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: side),
            label.heightAnchor.constraint(equalToConstant: side)
        ])
        
        contentView.layer.borderColor = UIColor.flatPeterRiver.cgColor
        contentView.layer.borderWidth = 2;
    }
    
    
    func config(_ text: String){
        label.text = text
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
}

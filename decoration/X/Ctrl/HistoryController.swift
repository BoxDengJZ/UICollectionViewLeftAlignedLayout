//
//  HistoryController.swift
//  petit
//
//  Created by Jz D on 2020/10/22.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit

class HistoryController: UIViewController {
    
    
    lazy var h: SideHeader = {
        let cao = SideHeader(title: "历史记录")
        cao.delegate = self
        return cao
    }()
    
    
    lazy var contentV: UICollectionView = {
        let f = DecorationFlow()
        f.minimumLineSpacing = CGFloat.zero
        f.minimumInteritemSpacing = CGFloat.zero
        
        let collect = UICollectionView(frame: .zero, collectionViewLayout: f)
        collect.delegate = self
        collect.dataSource  = self
        
        collect.register(cell: HistoryItem.self)
        collect.register(header: HistoTitleV.self)
        
        collect.register(footer: EmptyFooterV.self)
        collect.backgroundColor = UIColor.cloak
        collect.showsVerticalScrollIndicator = false
        collect.showsHorizontalScrollIndicator = false
        
        return collect
    }()
    
    
    var histories: [HistoryModel] = [.up, .down]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout_h()
        
        view.addSubs([contentV ])
        
        contentV.snp.makeConstraints { (m) in
            m.leading.trailing.bottom.equalToSuperview()
            m.top.equalTo(h.snp.bottom)
        }
        
    
    }
    

}






extension HistoryController: SideHeaderDelegate{
    
    
    func xForce() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

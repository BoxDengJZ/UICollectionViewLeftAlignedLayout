//
//  HistoryCtrl_colume.swift
//  petit
//
//  Created by Jz D on 2020/10/27.
//  Copyright © 2020 swift. All rights reserved.
//

import Foundation


extension HistoryController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UI.std.width, height: 80)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UI.std.width, height: 15)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionReusableView.header else {
            
            let foot = collectionView.dequeue(footer: EmptyFooterV.self, ip: indexPath)
            foot.decorateHis()
            return foot
        }
        
        let hed = collectionView.dequeue(header: HistoTitleV.self, ip: indexPath)
        
       
        let her = histories[indexPath.section]
        hed.title(name: her.title, press: her.publisher_name)
            
        
        
        return hed
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UI.std.width - 15 * 2, height: 50)
    }
    

}


extension HistoryController: UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
  
        return histories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return histories[section].histories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cel = collectionView.dequeue(cell: HistoryItem.self, ip: indexPath)
        
    
        let her = histories[indexPath.section]
        let sNMP = her.histories[indexPath.item]
        cel.title(name: sNMP.title, time: sNMP.finish_time)
        
        
        return cel
        
        
    }
    
    
    
    
    
    
}

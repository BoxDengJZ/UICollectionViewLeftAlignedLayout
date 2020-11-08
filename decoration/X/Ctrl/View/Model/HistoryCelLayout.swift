//
//  HistoryCelLayout.swift
//  petit
//
//  Created by Jz D on 2020/10/27.
//  Copyright © 2020 swift. All rights reserved.
//

import UIKit



class DecorationFlow: UICollectionViewFlowLayout {
    
    
    
    private var cache = [IndexPath: UICollectionViewLayoutAttributes]()
    
    
    override func prepare() {
        super.prepare()
        register(HistoDecorationV.self, forDecorationViewOfKind: HistoDecorationV.id)
        
        
        let originX: CGFloat = 15
        let widH: CGFloat = UI.std.width - originX * 2
        
        
        guard let collect = collectionView else{
            return
        }
        let sections = collect.numberOfSections
        var originY: CGFloat = 0
        for sect in 0..<sections{
            let sectionFirst = IndexPath(item: 0, section: sect)
            let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: HistoDecorationV.id, with: sectionFirst)
            let itemCount = collect.numberOfItems(inSection: sect)
            originY = originY + 80
            let h: CGFloat = 50 * CGFloat(itemCount)
            attributes.frame = CGRect(x: originX, y: originY, width: widH, height: h)
            originY = originY + h + 15
            cache[sectionFirst] = attributes
        }
        
        
    }
    
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    private func prepareCache() {
      cache.removeAll(keepingCapacity: true)
      cache = [IndexPath: UICollectionViewLayoutAttributes]()
    }
    
    
    
    
    // 同时不影响我们正常的 UICollectionViewDelegateFlowLayout 代理，设置布局信息
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return cache[indexPath]
        
    }
    // 涂色大法好，解决涂色部分
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array = super.layoutAttributesForElements(in: rect)
        guard let collection = collectionView, collection.numberOfSections > 0 else{
            return array
        }

        var z = 0
        
        array?.forEach({
            $0.zIndex = z + 100
            z += 1
        })
        
        z = 0
        for (_, attributes) in cache {
            
            if attributes.frame.intersects(rect){
                attributes.zIndex = z + 10
                array?.append(attributes)
            }
            z += 1
        }
        
        
        
        
        return array
        
    }
}




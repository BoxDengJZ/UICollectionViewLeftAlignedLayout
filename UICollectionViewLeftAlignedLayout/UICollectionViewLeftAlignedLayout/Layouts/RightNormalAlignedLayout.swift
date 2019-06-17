//
//  UICollectionViewRightAlignedLayout.swift
//  fuchou
//
//  Created by Jz D on 2019/5/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit

extension UICollectionViewLayoutAttributes {
    func trailingAlignFrame(with right:CGFloat){
        var tempFrame = frame
        tempFrame.origin.x += right
        frame = tempFrame
    }
}





class RightNormalAlignedLayout: UICollectionViewFlowLayout {
    
    
    fileprivate var cache = [IndexPath:UICollectionViewLayoutAttributes]()
    
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    var storedCellSize = [IndexPath: CGSize]()
    
    
    
    // 你妈的， 一多线程，多核心 CPU 异步绘制，又 gg 了
    
    func queryItemSize(_ indexPath: IndexPath) -> CGSize{
        guard let collectionView = collectionView else {
            return CGSize.zero
        }
        if let size = storedCellSize[indexPath]{
            return size
        }
        var indexPathSize = CGSize.zero
        if let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout{
            let currentSize = delegate.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath)
            if let currentItemSize = currentSize {
                indexPathSize = currentItemSize
            }
        }
        storedCellSize[indexPath] = indexPathSize
        return indexPathSize
    }
    
    
    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    let lock = NSLock()
    override func prepare() {
        lock.lock()
        contentHeight = 0
        cache.removeAll()
        storedCellSize.removeAll()
        guard let collectionView = collectionView else {
            return
        }
        var currentXOffset:CGFloat = 0
        var nextXOffset:CGFloat = 0
        var currentYOffset:CGFloat = 0
        var nextYOffset:CGFloat = 0
        
        
        for section in 0..<collectionView.numberOfSections{
            let sectionInset = evaluatedSectionInsetForItem(at: section)
            nextXOffset = sectionInset.left
            nextYOffset += sectionInset.top
            let count = collectionView.numberOfItems(inSection: section)
            for item in 0..<count{
                currentXOffset = nextXOffset
                currentYOffset = nextYOffset
                let indexPath = IndexPath(item: item, section: section)
                let currentItemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let currentIndexPathSize = queryItemSize(indexPath)
                let currentItemInNext = (currentXOffset + evaluatedMinimumInteritemSpacing(at: section) + currentIndexPathSize.width) > (collectionView.frame.width - sectionInset.right + 0.1)
                if currentItemInNext{
                    currentXOffset = sectionInset.left
                    currentYOffset += (currentIndexPathSize.height + evaluatedMinimumLineSpacing(at: section))
                    
                    nextXOffset = currentXOffset + (currentIndexPathSize.width + evaluatedMinimumInteritemSpacing(at: section))
                   
                    nextYOffset = currentYOffset
                }else{
                    nextXOffset += (currentIndexPathSize.width + evaluatedMinimumInteritemSpacing(at: section))
                }
                
                
                let frame = CGRect(origin: CGPoint(x: currentXOffset, y: currentYOffset), size: currentIndexPathSize)
                currentItemAttributes.frame = frame
                cache[indexPath] = currentItemAttributes
                
                contentHeight = max(contentHeight, frame.maxY)
                
            }
            nextYOffset = contentHeight
        }
        lock.unlock()
    }
    
    
    
    

    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesCopy: [UICollectionViewLayoutAttributes] = []
        if let attributes = super.layoutAttributesForElements(in: rect) {
            attributes.forEach({ attributesCopy.append($0.copy() as! UICollectionViewLayoutAttributes) })
        }
        
        for attributes in attributesCopy {
            if attributes.representedElementKind == nil {
                let indexpath = attributes.indexPath
                if let attr = layoutAttributesForItem(at: indexpath) {
                    attributes.frame = attr.frame
                }
            }
        }
        return attributesCopy
    }
    
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView,let attribute = cache[indexPath] else {
            return nil
        }
        
        var offsetX: CGFloat = attribute.frame.maxX
        let criteria = collectionView.frame.width - evaluatedSectionInsetForItem(at: indexPath.section).right - 0.1
        var gap = criteria - offsetX
        var ip = indexPath
        let sectionCount = collectionView.numberOfItems(inSection: indexPath.section)
        while ip.item < sectionCount{
            var conditionSecond = false
            if let nextAttri = cache[ip.next]{
                conditionSecond = nextAttri.frame.minY != attribute.frame.minY
            }
            if (ip.item + 1) >= sectionCount || conditionSecond {
                gap = criteria - offsetX
                break
            }
            else{
                ip = ip.next
                offsetX += (evaluatedMinimumInteritemSpacing(at: indexPath.section) + cache[ip]!.frame.width)
               
            }
        }
        attribute.trailingAlignFrame(with: gap)
        return attribute
        
    }
    
    func evaluatedMinimumInteritemSpacing(at sectionIndex:Int) -> CGFloat {
        if let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout, let collection = collectionView {
            let inteitemSpacing = delegate.collectionView?(collection, layout: self, minimumInteritemSpacingForSectionAt: sectionIndex)
            if let inteitemSpacing = inteitemSpacing {
                return inteitemSpacing
            }
        }
        return minimumInteritemSpacing
        
    }
    
    func evaluatedMinimumLineSpacing(at sectionIndex:Int) -> CGFloat {
        if let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout, let collection = collectionView {
            let lineSpacing = delegate.collectionView?(collection, layout: self, minimumLineSpacingForSectionAt: sectionIndex)
            if let lineSpacing = lineSpacing {
                return lineSpacing
            }
        }
        return minimumLineSpacing
        
    }
    
    func evaluatedSectionInsetForItem(at index: Int) ->UIEdgeInsets {
        if let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout, let collection = collectionView {
            let insetForSection = delegate.collectionView?(collection, layout: self, insetForSectionAt: index)
            if let insetForSectionAt = insetForSection {
                return insetForSectionAt
            }
        }
        return sectionInset
    }
}



extension IndexPath{
    
    var next: IndexPath{
        return IndexPath(item: item + 1, section: section)
    }
    
}

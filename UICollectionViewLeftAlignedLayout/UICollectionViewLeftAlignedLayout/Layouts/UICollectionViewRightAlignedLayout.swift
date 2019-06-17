//
//  UICollectionViewRightAlignedLayout.swift
//  fuchou
//
//  Created by Jz D on 2019/5/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit
extension UICollectionViewLayoutAttributes {
    func rightAlignFrame(with width:CGFloat){
        var tempFrame = frame
        tempFrame.origin.x = width - frame.size.width
        frame = tempFrame
    }
}

class UICollectionViewRightAlignedLayout: UICollectionViewFlowLayout {
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
        
        if let currentItemAttributes = super.layoutAttributesForItem(at: indexPath as IndexPath)?.copy() as? UICollectionViewLayoutAttributes , let collection = collectionView{
            let isFirstItemInSection = indexPath.item == 0
 
            
            if isFirstItemInSection {
                currentItemAttributes.rightAlignFrame(with: collection.frame.size.width)
                return currentItemAttributes
            }
            
            let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
            
            let previousFrame = layoutAttributesForItem(at: previousIndexPath)?.frame ?? CGRect.zero
  
            let currentFrame = currentItemAttributes.frame
            let strecthedCurrentFrame = CGRect(x: 0,
                                                    y: currentFrame.origin.y,
                                                    width: collection.frame.size.width,
                                                    height: currentFrame.size.height)
            // if the current frame, once left aligned to the left and stretched to the full collection view
            // widht intersects the previous frame then they are on the same line
            let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
            
            if isFirstItemInRow {
                // make sure the first item on a line is left aligned
                currentItemAttributes.rightAlignFrame(with: collection.frame.size.width)
                return currentItemAttributes
            }
            let previousFrameLeftPoint = previousFrame.origin.x
            var frame = currentItemAttributes.frame
            let minimumInteritemSpacing = evaluatedMinimumInteritemSpacing(at: indexPath.item)
            frame.origin.x = previousFrameLeftPoint - minimumInteritemSpacing - frame.size.width
            currentItemAttributes.frame = frame
            return currentItemAttributes
            
        }
        return nil
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
    

}


//  based on http://stackoverflow.com/questions/13017257/how-do-you-determine-spacing-between-cells-in-uicollectionview-flowlayout  https://github.com/mokagio/UICollectionViewLeftAlignedLayout

import UIKit
extension UICollectionViewLayoutAttributes {
    func leftAlignFrame(with sectionInset:UIEdgeInsets){
        var tempFrame = frame
        tempFrame.origin.x = sectionInset.left
        frame = tempFrame
    }
}

class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
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
        
        if let currentItemAttributes = super.layoutAttributesForItem(at: indexPath as IndexPath)?.copy() as? UICollectionViewLayoutAttributes, let collection = collectionView {
            let sectionInset = evaluatedSectionInsetForItem(at: indexPath.section)
            let isFirstItemInSection = indexPath.item == 0
            let layoutWidth = collection.frame.width - sectionInset.left - sectionInset.right
            
            guard !isFirstItemInSection else{
                currentItemAttributes.leftAlignFrame(with: sectionInset)
                return currentItemAttributes
            }
            
            let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
            
            let previousFrame = layoutAttributesForItem(at: previousIndexPath)?.frame ?? CGRect.zero
            let previousFrameRightPoint = previousFrame.origin.x + previousFrame.width
            let currentFrame = currentItemAttributes.frame
            let strecthedCurrentFrame = CGRect(x: sectionInset.left,
                                                    y: currentFrame.origin.y,
                                                    width: layoutWidth,
                                                    height: currentFrame.size.height)
            // if the current frame, once left aligned to the left and stretched to the full collection view
            // widht intersects the previous frame then they are on the same line
            let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
            
            guard !isFirstItemInRow else{
                // make sure the first item on a line is left aligned
                currentItemAttributes.leftAlignFrame(with: sectionInset)
                return currentItemAttributes
            }
            
            var frame = currentItemAttributes.frame
            frame.origin.x = previousFrameRightPoint + evaluatedMinimumInteritemSpacing(at: indexPath.section)
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

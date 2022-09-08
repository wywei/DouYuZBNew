//
//  PageContentView.swift
//  DYZB
//
//  Created by Andy on 2022/9/8.
//

import UIKit

protocol PageContentViewDelegate: AnyObject {
    
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}



private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    var delegate: PageContentViewDelegate?
    private var childVcs:[UIViewController] = []
    private weak var parentViewController: UIViewController?
    private var startOffsetX: CGFloat = 0
    private var isForbidScrollDelegate = false
    
    private lazy var collectionView: UICollectionView = { [weak self] in
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection  = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PageContentView {
    
    private func setupUI() {
        
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
   
        addSubview(collectionView)
        collectionView.frame = bounds
    }
  
}


extension PageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate { return }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currectOffsetX = scrollView.contentOffset.x
        let scollViewWidth: CGFloat = scrollView.frame.width
        if currectOffsetX > startOffsetX // 左滑
        {
            progress = (currectOffsetX/scollViewWidth) - floor(currectOffsetX/scollViewWidth)
            
            sourceIndex = Int(floor(currectOffsetX/scollViewWidth))
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if currectOffsetX - startOffsetX == scollViewWidth {
                progress = 1.0
                targetIndex = sourceIndex
            }
            
        } else {
            progress = 1 - ((currectOffsetX/scollViewWidth) - floor(currectOffsetX/scollViewWidth))

            targetIndex = Int(floor(currectOffsetX/scollViewWidth))
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
            if startOffsetX - currectOffsetX == scollViewWidth {
               sourceIndex = targetIndex
            }
            
        }
        
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    
}

extension PageContentView {
    
    func setCurrentIndex(currentIndex: Int) {
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex)*collectionView.frame.width
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
    
}

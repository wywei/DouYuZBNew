//
//  RecomendViewController.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyCellID = "kPrettyCellID"

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalH: CGFloat = kItemW * 3 / 4
private let kPrettyH: CGFloat = kItemW * 4 / 3

private let kHeaderViewH: CGFloat = 50

private let cycleViewH: CGFloat = kScreenH * 3 / 8

class RecomendViewController: UIViewController {

    private lazy var collectionView: UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        return collectionView
    }()
    private lazy var recommendViewModel = RecommendViewModel()
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect.init(x: 0, y: -cycleViewH, width: kScreenW, height: cycleViewH)
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
        
        setupUI()
        
        loadData()
        
    }
    
}

extension RecomendViewController {
    
    private func setupUI() {
        
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
   
        collectionView.contentInset = UIEdgeInsets(top: cycleViewH, left: 0, bottom: 0, right: 0)
    }
    
}

extension RecomendViewController {
    
    private func loadData() {
        recommendViewModel.testLoadData {
            self.collectionView.reloadData()
        }
    }
    
}


extension RecomendViewController: UICollectionViewDelegate {
    
}

extension RecomendViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorgroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendViewModel.anchorgroup[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendViewModel.anchorgroup[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        var cell: CollectionBaseCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        }
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = recommendViewModel.anchorgroup[indexPath.section]
        return headerView
    }
    
}

extension RecomendViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyH)
        }
        return CGSize(width: kItemW, height: kNormalH)
    }
    
}

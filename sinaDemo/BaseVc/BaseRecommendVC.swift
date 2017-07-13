//
//  BaseRecommendVC.swift
//  sinaDemo
//
//  Created by admin on 17/4/17.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit



class BaseRecommendVC: BaseVC {

    var baseVM: BaseVM!
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)

        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // 注册cell
        collectionView.register(CollectionNormalCell.self, forCellWithReuseIdentifier: NormalCellID)
        
        // 注册组头的View
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        
        return collectionView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setupUI()
        loadData()
        
    }


}


extension BaseRecommendVC {

    override func setupUI() {
        
        // 把父类的  contentView 替换成 子类(就是这个类里面)的 collectionView
        contentView = collectionView
        view.addSubview(collectionView)

        // 调用父类的设置UI
        super.setupUI()
        
    }
    
    func loadData() {
    
    }
    
}


extension BaseRecommendVC : UICollectionViewDelegate ,UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView.collectionViewLayout.invalidateLayout()
        
        return baseVM.anchorGroups.count

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
        
    }
    
    // 设置组头的View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.delegate = self
        headerView.total = baseVM.anchorGroups[indexPath.section].total
        headerView.group = baseVM.anchorGroups[indexPath.section].type
        
        return headerView
    }
    

}

extension BaseRecommendVC : CollectionHeaderViewDelegate{

    func moreLivingList(cataName: String, titleName: String) {
     
//        print(cataName , titleName)
        
        let moreVC = MoreLivingVC()
        moreVC.cataName = cataName
        moreVC.title = titleName
        
        navigationController?.pushViewController(moreVC, animated: true)
        
    }
    
}

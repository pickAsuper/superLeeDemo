//
//  BaseEntertainmentVC.swift
//  sinaDemo
//
//  Created by admin on 17/4/19.
//  Copyright © 2017年 super. All rights reserved.
//  首页的相关 BaseEntertainmentVC

import UIKit

class BaseEntertainmentVC: BaseVC {

    var baseVM : BaseVM!
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsetsMake(kItemMargin, kItemMargin, kItemMargin, kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(CollectionNormalCell.self, forCellWithReuseIdentifier: NormalCellID)
    
        return collectionView
    
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }

  
    
    

}


extension BaseEntertainmentVC {
    override func setupUI(){
      contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
    }

}

extension BaseEntertainmentVC {

    func loadData(){
    
    
    }

}

extension BaseEntertainmentVC :UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if baseVM.anchorGroups.count > 0 {
            return baseVM.anchorGroups[section].anchors.count
        }else{
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

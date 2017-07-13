//
//  RecommendVC.swift
//  sinaDemo
//
//  Created by admin on 17/4/12.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SnapKit

private let kCycleViewH : CGFloat = kScreenW * 2 / 5

class RecommendVC: BaseRecommendVC {

    
    fileprivate lazy var recommendVM : RecommendVM = RecommendVM()
    fileprivate lazy var cycleView : BannerCycleView = {
    
        let cycleView = BannerCycleView.init(frame: CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH))
        // 指定大小
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        cycleView.delegate = self
        return cycleView
        
    }()
    

  
}
extension RecommendVC {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(cycleView)
                
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH, 0, 0, 0)
    }

}

extension RecommendVC {
    override func loadData() {
        baseVM = recommendVM
        
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
        
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        self.loadDataFinished()
    }

}


extension RecommendVC : UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
      
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }

    
}


// 轮播图的点击事件
extension RecommendVC : BannerCycleViewDelegate {
 
    func collctionViewClick(collctionView: UICollectionView, indexPath: IndexPath) {
        
        print(indexPath.row)
        
        
    }
}

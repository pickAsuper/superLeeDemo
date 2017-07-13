//
//  MoreLivingVC.swift
//  sinaDemo
//
//  Created by admin on 17/4/19.
//  Copyright © 2017年 super. All rights reserved.
//  首页的相关 MoreLivingVC

import UIKit

class MoreLivingVC: BaseEntertainmentVC {

    var cataName : String = ""
    
    fileprivate lazy var moreLivingVM = MoreLivingVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    
    }

    
    override func loadData() {
        baseVM = self.moreLivingVM
        moreLivingVM.cate = cataName
        moreLivingVM.requestData{
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
    
  

}

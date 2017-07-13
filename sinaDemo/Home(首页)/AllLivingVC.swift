//
//  AllLivingVC.swift
//  sinaDemo
//
//  Created by admin on 17/4/12.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class AllLivingVC: BaseSearchVC {

    fileprivate lazy var allLivingVM = AllLivingVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension AllLivingVC {
    override func loadData() {
        baseVM = self.allLivingVM
        allLivingVM.requestData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}

//
//  AllLivingVM.swift
//  sinaDemo
//
//  Created by admin on 17/4/20.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class AllLivingVM: BaseVM {
 
    func requestData(finishedCallback : @escaping () -> ()) {
        loadSearchData(URLString: "http://api.m.panda.tv/ajax_live_lists?pageno=1&pagenum=20&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore", finishedCallback: finishedCallback)
    }
    
    
}

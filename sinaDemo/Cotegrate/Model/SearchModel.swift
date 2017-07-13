//
//  SearchModel.swift
//  sinaDemo
//
//  Created by admin on 17/4/14.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class SearchModel: NSObject {

//    lazy var anchors : [SearchListModel] = [SearchListModel]()
//    
//    var total = 0
//    var items : [[String : Any]]? {
//        didSet{
//            guard let item1 = items  else { return }
//            for dict in item1 {
//                anchors.append(SearchListModel(dict:dict))
//            }
//        }
//    }
//    
//    init(dict:[String : Any]) {
//        super.init()
//        setValuesForKeys(dict)
//        
//    }
//    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//    }
   
    
    lazy var anchors: [SearchListModel] = [SearchListModel]()
    var total: Int = 0
    var items: [[String: Any]]? {
        didSet {
            guard let items1 = items else { return }
            for dict in items1 {
                anchors.append(SearchListModel(dict: dict))
            }
        }
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }

    
}


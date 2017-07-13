//
//  BaseVM.swift
//  sinaDemo
//
//  Created by admin on 17/4/14.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class BaseVM: NSObject {

    
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    func loadAnchorGroupData(isLiveData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTool.request(type: .GET, urlString: URLString, paramters: parameters) { (result) in
            guard let dict = result as? [String : Any] else { return }
            if isLiveData {
                guard let dictionary = dict["data"] as? [String : Any] else { return }
                self.anchorGroups.append(AnchorGroup(dict: dictionary))
            } else {
                guard let arr = dict["data"] as? [[String : Any]] else { return }
                for dict in arr {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }
            finishedCallback()
        }
    }
    
    
    lazy var searchGroup: [SearchModel] = [SearchModel]()
    func loadSearchData(URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTool.request(type: .GET, urlString: URLString, paramters: parameters) { (result) in
            guard let dict = result as? [String : Any] else { return }
            guard let dictionary = dict["data"] as? [String : Any] else { return }
            self.searchGroup.append(SearchModel(dict: dictionary))
            finishedCallback()
        }
    }
}

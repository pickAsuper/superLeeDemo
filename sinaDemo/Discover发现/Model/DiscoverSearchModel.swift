//
//  DiscoverSearchModel.swift
//  sinaDemo
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON

class DiscoverSearchModel: NSObject {

    var activity_list = Array<ActivityModel>()
    var banner = Array<SearchBannerModel>()
    
    init(dic:JSON) {
        var array = Array<ActivityModel>()
        for (_,subJson):(String,JSON) in dic["activity_list"] {
        let model  = ActivityModel.init(dic: subJson)
            array.append(model)
        }
        
        self.activity_list = array
        
        var array2 = Array<SearchBannerModel>()
        for (_,subJson):(String,JSON) in dic["banner"] {
            let model = SearchBannerModel.init(dic: subJson)
            array2.append(model)
        }
        self.banner = array2
    }

}


class ActivityModel: NSObject {
    
    var title = String()
    var icon = String()
    
    var users = String()
    
    init(dic:JSON) {
        self.title = dic["title"].stringValue
        self.icon = dic["icon"].stringValue
        self.users = dic["users"].stringValue
        
    }
    
}
class SubjectModel: NSObject {
    
}


class SearchBannerModel: NSObject {
    var photo = String()
    
    init(dic:JSON) {
        self.photo = dic["photo"].stringValue
    }
}





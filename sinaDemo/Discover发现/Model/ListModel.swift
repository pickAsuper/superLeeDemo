//
//  ListModel.swift
//  sinaDemo
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON
class ListModel: NSObject {
    var post: PostModel!
    var topic: ListTopicModel!
    
    init(dic:JSON) {
        self.post = PostModel.init(dic:dic["post"])
        self.topic = ListTopicModel.init(dic:dic["topic"])
        
    }
    
    
    
}

class PostModel: NSObject {
    
    var middle_pic_url = String()
    var datestr = String()
    var content = String()
    var user : ListUserModel!
    var relation : RelationActivityModel!
    var dynamic : DynamicModel!
    
    
    init(dic:JSON) {
        self.middle_pic_url = dic["middle_pic_url"].stringValue
        self.datestr = dic["datestr"].stringValue
        self.content = dic["content"].stringValue
        self.user = ListUserModel.init(dic: dic["user"])
        self.relation = RelationActivityModel.init(dic: dic["relation_activity"])
        self.dynamic = DynamicModel.init(dic: dic["dynamic"])

    }
}



class DynamicModel: NSObject {
    var views  = String()
    var ispraise = Bool()
    
    var praises = String()
    
    init(dic: JSON) {
        self.views = dic["views"].stringValue
        self.ispraise = dic["ispraise"].boolValue
        self.praises = dic["praises"].stringValue
        
    }
    
}

class ListUserModel: NSObject {
    var avatar = String()
    var nickname = String()
    
    init(dic: JSON) {
        self.avatar = dic["avatar"].stringValue
        self.nickname = dic["nickname"].stringValue
        
    }
    
}

class ListTopicModel: NSObject {
   
    var share_pic = String()
    var datestr = String()
    var user : ListUserModel!
    var title = String()
    var relation : RelationActivityModel!
    var views = String()
    var ispraise = Bool()
    var praises = String()
    
    init(dic:JSON) {
        self.share_pic = dic["share_pic"].stringValue
        self.title = dic["title"].stringValue
        self.datestr = dic["datestr"].stringValue
        self.views = dic["views"].stringValue
        self.praises = dic["praises"].stringValue
        self.user = ListUserModel.init(dic: dic["user"])
        self.relation = RelationActivityModel.init(dic: dic["relation_activity"])
        self.ispraise = dic["ispraise"].boolValue
        
    }
    
}

class RelationActivityModel: NSObject {
    var title = String()
    
    init(dic:JSON) {
        self.title = dic["title"].stringValue
    }
    
}



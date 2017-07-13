//
//  OnLinePlayerConentModel.swift
//  sinaDemo
//
//  Created by admin on 2017/5/19.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON

class OnLinePlayerConentModel: NSObject {

    var channel_id = String()
    var cate_order = Int()
    var channel_name = String()
    var channel_order  = Int()
    var cate  = String()
    var source_type = Int()
    var cate_id = String()
    var pv_order = Int()
    var source_id = Int()

    init(dict:JSON) {
        self.channel_id = dict["channel_id"].stringValue
        self.cate_order = dict["cate_order"].intValue
        self.channel_name = dict["channel_name"].stringValue
        self.channel_order = dict["channel_order"].intValue
        self.cate = dict["cate"].stringValue
        self.source_type = dict["source_type"].intValue
        self.cate_id = dict["cate_id"].stringValue
        self.pv_order = dict["pv_order"].intValue
        self.source_id = dict["source_id"].intValue

    }
    /*
     "channel_id" : "public_shiguang_lvxing",
     "cate_order" : 2,
     "channel_name" : "旅行",
     "channel_order" : 10208,
     "cate" : "时光频道",
     "source_type" : 2,
     "cate_id" : "shiguang",
     "pv_order" : 8,
     "source_id" : 0
     */
}

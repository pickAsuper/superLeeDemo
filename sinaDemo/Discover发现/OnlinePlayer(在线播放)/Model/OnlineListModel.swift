//
//  OnlineListModel.swift
//  sinaDemo
//
//  Created by admin on 2017/5/19.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON
class OnlineListModel: NSObject {

    
    var id = Int()
    var method  = Int()
    var flow_mark = Int()
    var type = Int()
    
    
    init(dict:JSON) {
        self.id = dict["id"].intValue
        self.method = dict["method"].intValue
        self.flow_mark = dict["flow_mark"].intValue
        self.type = dict["type"].intValue
    }
}

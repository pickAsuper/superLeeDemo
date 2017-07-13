//
//  TypeModel.swift
//  sinaDemo
//
//  Created by admin on 17/4/14.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class TypeModel: NSObject {
   
    var ename: String = ""
    var cname: String = ""
    var icon: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}

//
//  CycleModel.swift
//  sinaDemo
//
//  Created by admin on 17/4/18.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var title : String = ""
    var smallimg : String = ""
    var bigimg : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}

//
//  QQMusicModel.swift
//  sinaDemo
//
//  Created by admin on 2017/5/12.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQMusicModel: NSObject {

    var name : String?
    var filename: String?
    var lrcname:String?
    var singer:String?
    var singerIcon :String?
    var icon: String?
    
    
    override init() {
        
    }
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

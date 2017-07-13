//
//  QQMusicMessageModel.swift
//  sinaDemo
//
//  Created by admin on 2017/5/15.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQMusicMessageModel: NSObject {

    var musicM : QQMusicModel?
    
    var costTime : TimeInterval = 0
    
    var totalTime : TimeInterval = 0
    
    var isPlaying : Bool = false
    
    var costTimeFormat : String {
        get {
         return QQTimeTool.getFormatTime(costTime)
        }
    }
    
    var totalTimeFormat: String {
        get {
         return QQTimeTool.getFormatTime(totalTime)
        }
    }
    
}

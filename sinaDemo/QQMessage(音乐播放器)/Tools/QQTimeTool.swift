//
//  QQTimeTool.swift
//  sinaDemo
//
//  Created by admin on 2017/5/15.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQTimeTool: NSObject {
 
     // 获取时间
    class func getFormatTime(_ timeInterval : TimeInterval) -> String {
        return String(format: "%02d: %02d", Int(timeInterval) / 60 , Int(timeInterval) % 60)
    }
    
    
    class func getTimeInterval(_ formatTime: String) -> TimeInterval {
        
        let minSec = formatTime.components(separatedBy: ":")

        if minSec.count != 2 {
            return 0
        }
        let min = TimeInterval(minSec[0]) ?? 0.0
        let sec = TimeInterval(minSec[1]) ?? 0.0
        
        return min * 60 + sec
        
        
    }
}

//
//  CALayer+Extension.swift
//  sinaDemo
//
//  Created by admin on 2017/5/17.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

extension CALayer {
 
    func pauseAnimate() {
        let pausedTime : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
        
    }

    func resumeAnimate() {
        let pausedTime : CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
    }
    
    

}

//
//  LCArrowBtn.swift
//  sinaDemo
//
//  Created by admin on 17/4/19.
//  Copyright © 2017年 super. All rights reserved.
//  首页的相关 LCArrowBtn

import UIKit

class LCArrowBtn: UIButton {

   
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.frame.origin.x = 5
        self.imageView?.frame.origin.x = (self.titleLabel?.frame.size.width)! + 5.0
    }

}

//
//  UIColor-Extention.swift
//  sinaDemo
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat,g: CGFloat,b: CGFloat) {
        self.init(red: r/255.0 ,green: g/255.0 ,blue: b/255.0 , alpha:1)
    }
    
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0 , green: gray/255.0 ,blue :gray/255.0 ,alpha:1)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}

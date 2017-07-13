//
//  QQImageTool.swift
//  sinaDemo
//
//  Created by admin on 2017/5/15.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQImageTool: NSObject {
    
    class func getNewImage(_ sourceImage: UIImage?, str: String?) -> UIImage? {
        guard let image = sourceImage else { return nil }
        guard let resultStr = str  else { return image }
        
        // 获取图片上下文
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let style = NSMutableParagraphStyle()
        
        style.alignment = .center
        
        let textRect = CGRect(x: 0, y: 0, width: image.size.width, height: 28)
        
        let textDic = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName: UIFont.systemFont(ofSize: 18),
            NSParagraphStyleAttributeName: style
        ]
        
        // 先转成 oc的 string 在画到 上下文上去
        (resultStr as NSString).draw(in: textRect, withAttributes: textDic)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultImage
        
    }
}

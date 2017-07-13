//
//  UIView+Ext.swift
//  ProjectSwift
//
//  Created by ZJQ on 2016/12/23.
//  Copyright © 2016年 ZJQ. All rights reserved.
// 

import UIKit

extension UIView {

    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    
    public var left: CGFloat{
        
        get {
            return self.frame.origin.x
        }
        set{
            
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
        
    }
    
    
    public var right: CGFloat{
    
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set{
        
            var r = self.frame
            r.origin.x = newValue - r.size.width
            self.frame = r
        }
    
    }

    public var top: CGFloat{
        
        get {
            return self.frame.origin.y
        }
        set{
            
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
        
    }

    
    public var bottom: CGFloat{
        
        get {
            return self.frame.origin.y+self.frame.size.height
        }
        set{
            
            var r = self.frame
            r.origin.y = newValue - self.frame.size.height
            self.frame = r
        }
        
    }
    
    public var width: CGFloat{
        
        get {
            return self.frame.size.width
        }
        set{
            
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
        
    }
    
    public var height: CGFloat{
        
        get {
            return self.frame.size.height
        }
        set{
            
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
        
    }
    
}

extension UIButton {

     class func sizeOfLabel(customMaxWidth: CGFloat,systemFontSize: CGFloat,filledTextString: String) -> CGSize {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: customMaxWidth, height: 0))
        label.text = filledTextString
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: systemFontSize)
        label.sizeToFit()
        
        let size = label.frame.size
        
        return size
    }

}

extension UIImage {

    class func image(color: UIColor, size: CGSize) -> UIImage {
    
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
}

extension UILabel {

    class func getStringWidth(text: String, size: CGFloat) -> CGFloat {
    
        let rect = text.boundingRect(with: CGSize.init(width: Double(MAXFLOAT), height: 10), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: size)], context: nil)
        
        return CGFloat(ceilf(Float(rect.width)))
    }

}

extension UIColor {

    public class func rgba(red: Float, green: Float, blue: Float, alpha: Float) -> UIColor {
    
        let color = UIColor.init(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
        
        return color
    }
}

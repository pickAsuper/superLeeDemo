//
//  LCTabBarButton.swift
//  sinaDemo
//
//  Created by admin on 2017/4/28.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCTabBarButton: UIButton {

    // 按钮的文字 和 图片 的比例
    let tabbarImageRatio = 0.65
    
    // 获取UITabBarItem 里面的文字和图片 通过set方法替换
    var item : UITabBarItem  = UITabBarItem(){
        didSet{
         self.setTitle(self.item.title, for: UIControlState())
         self.setTitle(self.item.title, for: .selected)
            
            self.setImage(self.item.image, for: UIControlState())
            self.setImage(self.item.selectedImage, for: .selected)
            
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 让图片居中
        self.imageView?.contentMode = .center
        
        // 去掉高亮状态
        self.adjustsImageWhenHighlighted = false
 
        // 让文字居中
        self.titleLabel?.textAlignment = .center
        
        // 文字的大小
        self.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        
        // 文字颜色
        self.setTitleColor(UIColor.orange, for: .selected)
        self.setTitleColor(UIColor.black, for: .normal)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 重写按钮的文字 和 图片的 位置
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY = contentRect.size.height * CGFloat(tabbarImageRatio)
        let titleH = contentRect.size.height - titleY
        let titleW = contentRect.size.width
        return CGRect(x: 0, y: titleY, width: titleW, height: titleH)

    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageH = contentRect.size.height * CGFloat(tabbarImageRatio)
        let imageW = contentRect.size.width
        return CGRect(x: 0, y: 0, width: imageW, height: imageH)
        
    }
}

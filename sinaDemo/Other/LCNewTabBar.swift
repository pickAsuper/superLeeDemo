//
//  LCNewTabBar.swift
//  sinaDemo
//
//  Created by admin on 2017/4/28.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

// tabbar 的代理方法
protocol LCNewTabBarDelegate  {
    func tabbar(_ tabbar : LCNewTabBar ,formWhichItem: Int,toWhichItem:Int);
    func plusBtnOnClicl()
}

class LCNewTabBar: UIView {

   
    // tabbar按钮数组
    var tabbarButtons : NSMutableArray = []
    
    // 选中的按钮
    var selectedButton = LCTabBarButton()
    
    var tabbarDelegate: LCNewTabBarDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTabbarButtonWith(_ item: UITabBarItem) -> Void {
       
        let button  = LCTabBarButton()
        // 把文字 和 图片 传进去
        button.item = item
        self.tabbarButtons.add(button)
        button.addTarget(self, action: #selector(buttonDidTouch), for: .touchUpInside)
        
        // 把按钮添加到这个View (LCNewTabBar) 上
        self.addSubview(button)
        
        // 默认选中第一个按钮
        if self.tabbarButtons.count == 1 {
            self.buttonDidTouch(self.tabbarButtons[0] as! LCTabBarButton)
        }
        
    }
    
    // 按钮的点击事件  由代理传出去
    func buttonDidTouch(_ button: LCTabBarButton) -> Void {
        tabbarDelegate?.tabbar(self, formWhichItem: self.selectedButton.tag, toWhichItem: button.tag)
        
        self.selectedButton.isSelected = false
        button.isSelected = true
        self.selectedButton = button
    }
    
    
    // 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonW = self.frame.size.width/CGFloat(self.tabbarButtons.count + 1)
        let buttonH = self.frame.size.height
        let buttonY = 0
        
        for index in 0...self.tabbarButtons.count - 1 {
            // 取出按钮
            let button : UIButton = self.tabbarButtons[index] as! UIButton
            
            let buttonX = CGFloat(index) * buttonW
            let btnX = CGFloat(index + 1) * buttonW
            
            if index < 2 {
                button.frame = CGRect(x: buttonX, y: CGFloat(buttonY), width: buttonW, height: buttonH)
            }else{
              button.frame = CGRect(x: btnX, y: CGFloat(buttonY), width: buttonW, height: buttonH)
            }
            
            self.addSubview(button)
            
            button.tag = index
        }
        
        // 添加 加号 按钮
        let plusBtn = UIButton.init(type: .custom)
        plusBtn.frame = CGRect(x: CGFloat(2) * buttonW, y: CGFloat(buttonY), width: buttonW, height: buttonH)
        plusBtn.setImage(UIImage(named:"plus_normal"), for: .normal)
        plusBtn.setImage(UIImage(named:"plus_pressed"), for: .highlighted)
        plusBtn.addTarget(self, action: #selector(plusBtnClick), for: .touchUpInside)
        self.addSubview(plusBtn)

        
    }
    
    
    func plusBtnClick() {
        tabbarDelegate?.plusBtnOnClicl()
        
    }
    

}

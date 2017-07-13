//
//  LCTabBar.swift
//  sinaDemo
//
//  Created by admin on 17/4/8.
//  Copyright © 2017年 super. All rights reserved.
//

// ---------- 已经不用这个了 -------


// ===========使用 LCNewTabBar.swift ==========
import UIKit

class LCTabBar: UITabBar {

    fileprivate var tabbarMidBtn = LCTabbarMidBtn()
    
    
    fileprivate lazy var btnImages :[String] = {
      return ["tabbar_home","tabbar_message_center","tabbar_compose_button","tabbar_discover","tabbar_profile"]
    }()
    
    fileprivate lazy var buttons : [UIButton] = {
    
        return [UIButton]()
        
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
       let count = buttons.count
       let w = bounds.width / CGFloat(count)
       let h = bounds.height
       
        let frame = CGRect(x: 0, y: 0, width: w, height: h)
        for btn in buttons {
            btn.frame = frame.offsetBy(dx: CGFloat(btn.tag) * w, dy: 0)
        }
        
    }
    
    // 通过代码创建
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        for i in 0..<btnImages.count {
            let imageName = btnImages[i]
            let btn = buttonWithImageName(imageName)
            
            btn.tag = i
           
            if i==0 {
                buttonClick(btn)
            }
            
            addSubview(btn)
            buttons.append(btn)
            
        }

    
    }
    
    // 通过XIB创建
    override func awakeFromNib() {
      super.awakeFromNib()
        for i in 0..<btnImages.count {
            let imageName = btnImages[i]
            let btn = buttonWithImageName(imageName)
             btn.tag = i
            if i==0 {
                buttonClick(btn)
            }
            
            addSubview(btn)
            buttons.append(btn)
            
        }
        
    }
    
      required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置按钮
    fileprivate func buttonWithImageName(_ imageName: String)->LCTabbarMidBtn{
        let b = LCTabbarMidBtn(type: .custom)
        b.setImage(UIImage(named:imageName), for: UIControlState())
        b.setImage(UIImage(named: imageName + "_highlighted"), for: .selected)
        b.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        return b
        
    }
    
    // 按钮点击事件
    func buttonClick(_ button:LCTabbarMidBtn) {
        guard tabbarMidBtn != button else {
            return
        }
        
        if button.tag != 2 {
            tabbarMidBtn.isSelected = false
            button.isSelected = true
            tabbarMidBtn = button
        }
    }
    

}

//
//  SearchSegmentView.swift
//  sinaDemo
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class SearchSegmentView: UIView {

    // 创建button的数组
    var btns = Array<UIButton>()
    
    // 底部滑动的横线
    var redLineView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        redLineView = UIView()
        redLineView.backgroundColor = UIColor.red
        
        self.addSubview(redLineView)
        
        // 添加按钮
        let titleArray = ["最新","推荐","关注"]
        for index in 0...2 {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: CGFloat(index) * (kScreenW/3), y: 0, width: kScreenW/3, height: 45)
            btn.setTitle(titleArray[index], for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitleColor(UIColor.red, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.addTarget(self, action: #selector(changeSelectedItem(_:)), for: .touchUpInside)
            self.addSubview(btn)
            
            // 第一次进来选中第一个 在设置红线位置大小
            if index == 0 {
              btn.isSelected = true
                redLineView.center = CGPoint(x: btn.center.x, y: btn.bottom)
                redLineView.bounds = CGRect(x: 0, y: 0, width: 30, height: 3)
            }
            self.btns.append(btn)
            
        }
        
        
    }
    
    // 按钮点击事件
    func changeSelectedItem(_ button: UIButton){
      
        for btn in self.btns {
            btn.isSelected = false
        }
        
        button.isSelected = true
        
        UIView.animate(withDuration: 0.3) { 
            self.redLineView.center = CGPoint(x: button.center.x, y: button.bottom+3)
            self.redLineView.bounds = CGRect(x: 0, y: 0, width: 30, height: 3)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}

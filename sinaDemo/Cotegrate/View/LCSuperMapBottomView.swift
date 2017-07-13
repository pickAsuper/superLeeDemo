//
//  LCSuperMapBottomView.swift
//  sinaDemo
//
//  Created by admin on 2017/5/23.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCSuperMapBottomView: UIView {

    
    lazy var oneButton : UIButton = {
        let oneButton = UIButton()
        oneButton.setTitle("显示定位", for: .normal)
        oneButton.setTitle("不显示定位", for: .selected)
        oneButton.setTitleColor(UIColor.white, for: .normal)
//        oneButton.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        return oneButton
        
    }()

    lazy var twoButton : UIButton = {
        let twoButton = UIButton()
        twoButton.setTitle("显示路线", for: .normal)
        twoButton.setTitle("不显示路线", for: .selected)
        twoButton.setTitleColor(UIColor.white, for: .normal)
        //        oneButton.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        return twoButton
        
    }()
    
    lazy var threeButton : UIButton = {
        let threeButton = UIButton()
        threeButton.setTitle("显示标准", for: .normal)
        threeButton.setTitle("显示卫星图", for: .selected)
        threeButton.setTitleColor(UIColor.white, for: .normal)
        //        oneButton.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        return threeButton
        
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      
        let btnW :CGFloat = kScreenW / 3

        oneButton.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        twoButton.frame = CGRect(x: btnW, y: 0, width: btnW, height: 40)
        threeButton.frame = CGRect(x: btnW + btnW, y: 0, width: btnW, height: 40)
        self.addSubview(oneButton)
        self.addSubview(twoButton)
        self.addSubview(threeButton)


        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

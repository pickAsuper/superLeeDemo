//
//  ShareBottomView.swift
//  sinaDemo
//
//  Created by admin on 2017/5/4.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class ShareBottomView: UIView {

    var viewsLabel = UILabel()
    var zanBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        setupSubViews()
    }
    
    func setupSubViews() {
        let ImgArray = ["zan","pinglun","share"]
        let text = ["赞","评论","分享"]
     
        for index in 0...2 {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: CGFloat(index * 60), y: 0, width: 60, height: self.height)
            btn.setTitle(text[index], for: .normal)
            btn.setImage(UIImage(named:ImgArray[index]), for: .normal)
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn.tag = index
            self.addSubview(btn)
            
            if index == 0 {
                self.zanBtn = btn
            }
        
        }
    
        
        viewsLabel = UILabel(frame: CGRect(x: kScreenW-60, y: 0, width: 60, height: self.height))
        viewsLabel.font = UIFont.systemFont(ofSize: 11)
        viewsLabel.textColor = UIColor.lightGray
        self.addSubview(viewsLabel)
        
    }

    func send(views:String , ispraise: Bool, praises: String) {
        
        if ispraise == true {
            self.zanBtn.setImage(UIImage(named:""), for: .normal)
            
        }
        if praises.isEmpty == false {
            self.zanBtn.setTitle(praises, for: .normal)
        }
        
        viewsLabel.text = "\(views)浏览"
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

//
//  QQDetailMiddleVIew.swift
//  sinaDemo
//
//  Created by admin on 2017/5/16.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQDetailMiddleVIew: UIView {

    // 前部的图片
    var foreImageView = UIImageView()
    
    // 歌词label
    // 显示 歌词的文本
    var lrcLabel = QQLrcLabel()
    
    
    var amazingBtn = UIButton()
    
    // 歌词滚动的View
    var lrcScrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupUI()

    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension QQDetailMiddleVIew {

    func setupUI(){
        
        
        foreImageView.image = UIImage(named:"jay.jpg")
        foreImageView.backgroundColor = UIColor.red
        foreImageView.frame = CGRect(x: 35, y: 56, width: kScreenW - 35 * 2, height: kScreenW - 35 * 2)
        foreImageView.layer.cornerRadius = (kScreenW - 35 * 2) * 0.5
        foreImageView.layer.masksToBounds = true
        foreImageView.isUserInteractionEnabled = true
        self.addSubview(foreImageView)
        
        lrcLabel = QQLrcLabel()
        lrcLabel.textAlignment = .center
        lrcLabel.textColor = UIColor.white
        lrcLabel.font = UIFont.systemFont(ofSize: 14)
        lrcLabel.frame = CGRect(x: 35, y: foreImageView.bottom + 10, width: foreImageView.width, height: 20)
        self.addSubview(lrcLabel)
 
        
        lrcScrollView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - 125 - 130)
        self.addSubview(lrcScrollView)
 
        amazingBtn = UIButton(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - 125 - 130))
        amazingBtn.backgroundColor = UIColor.clear
        lrcScrollView.addSubview(amazingBtn)
    
    }


}

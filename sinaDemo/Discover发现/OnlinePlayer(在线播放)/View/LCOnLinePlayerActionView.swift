//
//  LCOnLinePlayerActionView.swift
//  sinaDemo
//
//  Created by admin on 2017/5/22.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCOnLinePlayerActionView: UIView {

    
    lazy var otherBtn : UIButton = {
     let otherBtn = UIButton()
        otherBtn.setBackgroundImage(UIImage(named:"addbutton_43x40_"), for: .normal)
        
         return otherBtn
    }()
    lazy var playBtn : UIButton = {
        let playBtn = UIButton()
        playBtn.setBackgroundImage(UIImage(named:"fingerprint@2x.png"), for: .normal)
//        playBtn.setBackgroundImage(UIImage(named:"在线播放器暂停"), for: .selected)
        playBtn.isSelected = true
        playBtn.layer.cornerRadius = 20
        playBtn.layer.masksToBounds = true
        return playBtn
    }()
    
    lazy var preBtn : UIButton = {
        let preBtn = UIButton()
        preBtn.setBackgroundImage(UIImage(named:"在线播放器上一曲按钮"), for: .normal)
        preBtn.layer.cornerRadius = 20
        preBtn.layer.masksToBounds = true
        return preBtn
    }()

    lazy var nextBtn : UIButton = {
        let nextBtn = UIButton()
        nextBtn.setBackgroundImage(UIImage(named:"在线播放器下一曲"), for: .normal)
        nextBtn.layer.cornerRadius = 20
        nextBtn.layer.masksToBounds = true
        
        return nextBtn
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(otherBtn)
        
         self.addSubview(playBtn)
         playBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(40)
            make.height.equalTo(40)
            
        }
        
        self.addSubview(preBtn)
        preBtn.frame = CGRect(x: kScreenW / 5, y: 10, width: 40, height: 40)
        
        self.addSubview(nextBtn)
        nextBtn.frame = CGRect(x: (kScreenW / 5) * 3 + 40 , y: 10, width: 40, height: 40)
        
        preBtn.isHidden = true
        nextBtn.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

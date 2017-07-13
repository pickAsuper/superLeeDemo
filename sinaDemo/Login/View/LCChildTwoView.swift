//
//  LCChildTwoView.swift
//  sinaDemo
//
//  Created by admin on 17/4/21.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCChildTwoView: UIView {

    
    lazy var bgView : UIView = {
     let bgView = UIView()
        bgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        bgView.layer.cornerRadius = 40.0
        self.addSubview(bgView)
        return bgView
    }()
    
    lazy var topImageView : UIImageView  = {
      let topImageView = UIImageView()
        topImageView.image = UIImage(named: "music")
        self.bgView.addSubview(topImageView)
        
     return topImageView
    
    }()
    
    lazy var labelBgView : UIView = {
        let labelBgView = UIView()
        labelBgView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        self.addSubview(labelBgView)
        return labelBgView
    }()
    
    lazy var textStringLabel : UILabel = {
     let textStringLabel = UILabel()
        textStringLabel.text = "Music, at its essence, is what gives us memories. And the longer a song has existed in our lives, the more memories we have of it"
        textStringLabel.textColor = UIColor.white
        textStringLabel.font = UIFont.systemFont(ofSize: 15)
        textStringLabel.numberOfLines = 0
        textStringLabel.sizeToFit()
        
        self.labelBgView.addSubview(textStringLabel)
       return  textStringLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(150)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
        topImageView.snp.makeConstraints({ (make) in
            make.center.equalTo(self.bgView.snp.center)
//            make.top.equalTo(200)
            make.width.equalTo(34)
            make.height.equalTo(34)
        })
      
        labelBgView.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.bottom).offset(21)
            make.left.equalTo(self.snp.left)
            make.width.equalTo(kScreenW)
            make.height.equalTo(200)
        }
        
        textStringLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.labelBgView.snp.left).offset(10)
            make.right.equalTo(self.labelBgView.snp.right).offset(-10)
            make.top.equalTo(self.labelBgView.snp.top)
//            make.width.equalTo(kScreenW)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    

}

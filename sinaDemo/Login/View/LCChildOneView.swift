//
//  LCChildOneView.swift
//  sinaDemo
//
//  Created by admin on 17/4/21.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCChildOneView: UIView {

    lazy var titleStringLabel : UILabel = {
      let titleStringLabel = UILabel()
        titleStringLabel.text = "SUPER VIEW"
        titleStringLabel.textColor = UIColor.white
        titleStringLabel.frame = CGRect(x: self.center.x, y: 150, width: kScreenW, height: 30)
        titleStringLabel.font = UIFont.systemFont(ofSize: 20)
        titleStringLabel.textAlignment = .center
       return titleStringLabel
    
    }()
    
    lazy var textStrLabel : UILabel = {
        let textStrLabel = UILabel()
        textStrLabel.text = "Do you like it?"
        textStrLabel.textColor = UIColor.white
        textStrLabel.frame = CGRect(x: self.center.x, y: 180, width: kScreenW, height: 30)
        textStrLabel.font = UIFont.systemFont(ofSize: 13)
        textStrLabel.textAlignment = .center
        return textStrLabel
        
    }()

    lazy var midBgView : UIView = {
        let midBgView = UIView()
        let Wa :CGFloat = 160.0
        let w = kScreenW - Wa
        midBgView.frame = CGRect(x: kScreenW - w -  Wa * 0.5 , y: kScreenH / 2 , width: w, height: 100)
//        midBgView.backgroundColor = UIColor.yellow
        return midBgView
        
    }()

  
    // Continue with
    lazy var otherLabel : UILabel = {
      let otherLabel = UILabel()
          otherLabel.text = "Continue with"
          otherLabel.frame = CGRect(x: 0, y: 0, width: self.midBgView.frame.size.width, height: 20)
//          otherLabel.backgroundColor = UIColor.lightGray
          otherLabel.textColor = UIColor.white
          otherLabel.textAlignment = .center
        return otherLabel
    }()
    
    // instagramBtn
    lazy var instagramBtn :UIButton = {
      let instagramBtn = UIButton()
        instagramBtn.setImage(UIImage(named:"Instagram"), for: .normal)
//        instagramBtn.backgroundColor = UIColor.red
        instagramBtn.frame = CGRect(x: 0, y: 65 - 20 , width: 28.5, height: 28.5)
        
       return instagramBtn
    
    }()
    
    // Twitter
    lazy var twitterBtn :UIButton = {
        let twitterBtn = UIButton()
        twitterBtn.setImage(UIImage(named:"Twitter"), for: .normal)
//        twitterBtn.backgroundColor = UIColor.red
        twitterBtn.frame = CGRect(x: self.midBgView.center.x / 2 + 14, y: 65 - 20 , width: 28.5, height: 28.5)
        
        return twitterBtn
        
    }()
    
    // googlePlusBtn
    lazy var googlePlusBtn :UIButton = {
        let googlePlusBtn = UIButton()
        googlePlusBtn.setImage(UIImage(named:"GooglePlus"), for: .normal)
//        googlePlusBtn.backgroundColor = UIColor.red
        googlePlusBtn.frame = CGRect(x: self.midBgView.frame.width - 28.5, y: 65 - 20 , width: 28.5, height: 28.5)
        
        return googlePlusBtn
        
    }()
    
    
    lazy var oneLineView : UIView = {
    let oneLineView = UIView()
        oneLineView.frame = CGRect(x: self.midBgView.frame.width / 3 - 10, y: self.instagramBtn.frame.origin.y + 2, width: 1, height: 24)
 

        oneLineView.backgroundColor = UIColor.white
        
        return oneLineView
    }()
    
    
    lazy var twoLineView : UIView = {
        let twoLineView = UIView()
        twoLineView.frame = CGRect(x: self.twitterBtn.frame.origin.x + 26 + 40 , y: self.instagramBtn.frame.origin.y + 2, width: 1, height: 24)
        twoLineView.backgroundColor = UIColor.white
        
        return twoLineView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        setupUI()
        
  

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension LCChildOneView {
    func setupUI()  {
   
        self.addSubview(titleStringLabel)
        self.addSubview(textStrLabel)
        self.addSubview(midBgView)
        midBgView.addSubview(otherLabel)
        midBgView.addSubview(instagramBtn)
        midBgView.addSubview(twitterBtn)
        midBgView.addSubview(googlePlusBtn)
        midBgView.addSubview(oneLineView)
        midBgView.addSubview(twoLineView)

    }

}

//
//  CollectionSearchCell.swift
//  sinaDemo
//
//  Created by admin on 17/4/20.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class CollectionSearchCell: UICollectionViewCell {
    // 大的背景View
    lazy var bgView :UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgView.frame = self.contentView.frame
        
        return bgView
    }()
    
    lazy var topImageView : UIImageView = {
        let topImageView = UIImageView()
        topImageView.image = UIImage(named: "homepage_refresh_tv")
        topImageView.frame = CGRect(x: 0, y: 0, width: self.bgView.frame.width, height: self.bgView.frame.height - 30)
        return topImageView
    }()
    
    
    lazy var titleStringLabel : UILabel = {
        let titleStringLabel = UILabel()
        titleStringLabel.text = "吃货天堂：重庆美食"
        titleStringLabel.frame = CGRect(x: 5, y: 0, width: self.contentView.frame.width - 5, height: 20)
        titleStringLabel.font = UIFont.systemFont(ofSize: 11)
        titleStringLabel.textColor = UIColor.white
        
        return titleStringLabel
    }()
    
    lazy var TMLabelView : UIView = {
        let TMLabelView = UIView()
        TMLabelView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        TMLabelView.frame = CGRect(x: 0, y: self.topImageView.frame.height - 20, width: self.contentView.frame.width, height: 20)
        TMLabelView.addSubview(self.titleStringLabel)
        
        return TMLabelView
    }()
    
    
    
    lazy var bottomView : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.init(r: 246, g: 246, b: 246)
        bottomView.frame = CGRect(x: 0, y: self.topImageView.frame.height, width: self.contentView.frame.width, height: 30)
        return bottomView
    }()
    
    lazy var stringLabel : UILabel = {
        let stringLabel = UILabel()
        stringLabel.text = "我勒个去"
        stringLabel.frame = CGRect(x: 5, y: 0, width: self.bottomView.frame.width - 65, height: self.bottomView.frame.height)
        stringLabel.font = UIFont.systemFont(ofSize: 13)
        //        stringLabel.backgroundColor = UIColor.green
        
        return stringLabel
        
    }()
    
    lazy var lookNumBtn : UIButton = {
        let lookNumBtn = UIButton()
        lookNumBtn.setImage(UIImage(named:"look_image"), for: .normal)
        lookNumBtn.setTitle("63", for: .normal)
        lookNumBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        lookNumBtn.setTitleColor(UIColor.black, for: .normal)
        lookNumBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2)
        lookNumBtn.sizeToFit()
        lookNumBtn.frame.origin.x =  self.contentView.frame.width - lookNumBtn.frame.width - 8
        lookNumBtn.frame.size.width += 5
        lookNumBtn.frame.size.height = 30.0
        
        //        lookNumBtn.backgroundColor = UIColor.yellow
        return lookNumBtn
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        topImageView.contentMode = .scaleAspectFit
        bgView.addSubview(topImageView)
        bgView.addSubview(TMLabelView)
        bgView.addSubview(bottomView)
        bottomView.addSubview(stringLabel)
        bottomView.addSubview(lookNumBtn)
        self.contentView.addSubview(bgView)
        
    }
    
    
    var anchor : SearchListModel? {
        didSet {
            guard let anchor = anchor else { return }
            var onlineStr : String = ""
            if anchor.person_num >= 10000 {
                onlineStr = String(format:"%.1f万",Float(anchor.person_num) / 10000)
            } else {
                onlineStr = "\(anchor.person_num)"
            }
            lookNumBtn.setTitle(onlineStr, for: UIControlState())
           
            lookNumBtn.sizeToFit()
            lookNumBtn.frame.origin.x =  self.contentView.frame.width - lookNumBtn.frame.width - 8
            lookNumBtn.frame.size.width += 5
            lookNumBtn.frame.size.height = 30.0
            
            titleStringLabel.text = anchor.name
            stringLabel.text = anchor.nickname
            
            if let picture = anchor.pictures {
                guard let iconURL = URL(string: picture["img"] as! String) else { return }
                topImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "homepage_refresh_tv"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
            }
        }
    }

    
}

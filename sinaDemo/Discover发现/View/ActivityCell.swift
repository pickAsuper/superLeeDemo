//
//  ActivityCell.swift
//  sinaDemo
//
//  Created by admin on 2017/5/4.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class ActivityCell: UICollectionViewCell {
    
    var img = UIImageView()
    var title = UILabel()
    var subTitle  = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.white
        
        
        img.center = CGPoint(x: self.contentView.center.x - 30, y: self.contentView.center.y)
        img.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.contentView.addSubview(img)
        
        title = UILabel(frame: CGRect(x: img.right + 5, y: img.top, width: self.contentView.width - img.right - 20, height: 15))
        
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(title)
        
        subTitle = UILabel(frame: CGRect(x: img.right + 5, y: title.bottom+10, width: self.contentView.width-img.right-20, height: 10))
        subTitle.font = UIFont.systemFont(ofSize: 10)
        subTitle.textAlignment = .left
        subTitle.textColor = UIColor.lightGray
        self.contentView.addSubview(subTitle)
        
    }
    
    func sendModel(model: ActivityModel) {
        guard let iconURL = URL(string:model.icon ) else { return }
        self.img.kf.setImage(with: iconURL, placeholder: UIImage(named:""), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        self.title.text = model.title
        
        if model.users.isEmpty == true {
            self.subTitle.text = "新鲜上线"
            self.subTitle.textColor = UIColor(colorLiteralRed: 255/255.0, green: 95/255.0, blue: 102/255.0, alpha: 1)
        }else{
            self.subTitle.text = "\(model.users)人参与"
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//
//  CollectionCycleCell.swift
//  sinaDemo
//
//  Created by admin on 17/4/18.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    
    var iconImageView: UIImageView!
    
    var titleStringLabel : UILabel!
    

    func setupUI() {
        self.backgroundColor = UIColor.white
        
        self.iconImageView = UIImageView()
        self.iconImageView.isUserInteractionEnabled = true
        self.iconImageView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 200)
        
        self.titleStringLabel = UILabel()
        self.titleStringLabel.text = ""
        self.titleStringLabel.font = UIFont.systemFont(ofSize: 13)
        self.titleStringLabel.frame = CGRect(x:  0, y:  163, width: iconImageView.frame.width, height: 20)
        self.titleStringLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        
        self.addSubview(iconImageView)
      
        self.iconImageView.addSubview(self.titleStringLabel)
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleStringLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.bigimg ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "homepage_refresh_tv"))
        }
    }

}

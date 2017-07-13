//
//  QQLrcCell.swift
//  sinaDemo
//
//  Created by admin on 2017/5/16.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQLrcCell: UITableViewCell {

    var lrcLabel = QQLrcLabel()
    
    var progress: CGFloat = 0 {
        didSet{
           lrcLabel.radio = progress
        }
    
    }
    
    var  lrcContent: String = "" {
        didSet{
         lrcLabel.text = lrcContent
        }
    }
    

    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        lrcLabel.textColor = UIColor.white
        lrcLabel.textAlignment = .center
        lrcLabel.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(lrcLabel)

        lrcLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

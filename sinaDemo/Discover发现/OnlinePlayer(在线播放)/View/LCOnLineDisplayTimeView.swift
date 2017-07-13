//
//  LCOnLineDisplayTimeView.swift
//  sinaDemo
//
//  Created by super on 2017/5/20.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCOnLineDisplayTimeView: UIView {

        
      
    
    
    lazy var yearLabel :UILabel = {
        
        let yearLabel = UILabel()
        var currentDate = Date()
        let dateFormatter  = DateFormatter()
        
        // 设置本地时区
        dateFormatter.locale = Locale.current

        dateFormatter.dateStyle = DateFormatter.Style.short
        var stringDate = dateFormatter.string(from: currentDate)
        
        yearLabel.text = stringDate
        yearLabel.font = UIFont.systemFont(ofSize: 13)
        yearLabel.textColor = UIColor.orange
        yearLabel.sizeToFit()
        
        return yearLabel
    }()
    
    lazy var timeLabel :UILabel = {
        
        let timeLabel = UILabel()
        var currentDate = Date()
        let dateFormatter  = DateFormatter()
        
        // 设置本地时区
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        
        var stringDate = dateFormatter.string(from: currentDate)
        
        timeLabel.text = stringDate
        timeLabel.font = UIFont.boldSystemFont(ofSize: 40)
        timeLabel.textColor = UIColor.orange
        timeLabel.sizeToFit()
        
        return timeLabel
    }()
    
    lazy var weekLabel :UILabel = {
        
        let weekLabel = UILabel()
        var currentDate = Date()
        let dateFormatter  = DateFormatter()
        
        
        // 设置本地时区
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "EEEE"
        var stringDate = dateFormatter.string(from: currentDate)
        weekLabel.text = stringDate
        weekLabel.font = UIFont.italicSystemFont(ofSize: 26)
        weekLabel.textColor = UIColor.orange
        weekLabel.sizeToFit()
        
        return weekLabel
    }()
    
    
    lazy var weekLabel11 :UILabel = {
        
        let weekLabel = UILabel()
        var currentDate = Date()
        let dateFormatter  = DateFormatter()
        
        
        // 设置本地时区
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "EEEE"
        var stringDate = dateFormatter.string(from: currentDate)
        weekLabel.text = stringDate
        weekLabel.font = UIFont.italicSystemFont(ofSize: 26)
        weekLabel.textColor = UIColor.orange
        weekLabel.sizeToFit()
        
        return weekLabel
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(yearLabel)
        self.addSubview(timeLabel)
        self.addSubview(weekLabel)

        yearLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(80)
            make.left.equalTo(20)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.yearLabel.snp.bottom)
            make.left.equalTo(20)
        }
        weekLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.timeLabel.snp.bottom)
            make.left.equalTo(20)
        }

       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


extension LCOnLineDisplayTimeView {

  



}

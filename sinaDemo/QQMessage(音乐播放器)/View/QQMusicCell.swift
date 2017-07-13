//
//  QQMusicCell.swift
//  sinaDemo
//
//  Created by admin on 2017/5/15.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQMusicCell: UITableViewCell {

    var singerIconImageView = UIImageView()
    var songNameLabel = UILabel()
    var singerNameLabel = UILabel()
    
    
    
    var musicM : QQMusicModel? {
        didSet{
            if musicM?.singerIcon != nil {
               singerIconImageView.image = UIImage(named: (musicM?.singerIcon)!)
            }
       
            songNameLabel.text = musicM?.name
            singerNameLabel.text = musicM?.singer
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        singerIconImageView.layer.cornerRadius = 40 * 0.5
        singerIconImageView.layer.masksToBounds = true
        
        songNameLabel.textColor = UIColor.orange
        singerNameLabel.textColor = UIColor.orange
        singerNameLabel.font = UIFont.systemFont(ofSize: 14)
        
        
        self.contentView.addSubview(singerIconImageView)
        self.contentView.addSubview(songNameLabel)
        self.contentView.addSubview(singerNameLabel)

        
        singerIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        

        
       // 歌曲名
        songNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.singerIconImageView.snp.right).offset(20)
            make.height.equalTo(20)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
        }

        // 歌手名
        singerNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.singerIconImageView.snp.bottom).offset(5)
            make.left.equalTo(self.singerIconImageView.snp.right).offset(20)
            make.height.equalTo(20)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
        }
        
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

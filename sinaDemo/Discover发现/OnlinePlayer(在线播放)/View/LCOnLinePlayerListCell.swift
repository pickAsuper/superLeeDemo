//
//  LCOnLinePlayerListCell.swift
//  sinaDemo
//
//  Created by admin on 2017/5/19.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCOnLinePlayerListCell: UITableViewCell {

    
    // 头像
    var iconView = UIImageView()
    
    // 歌曲名
    var musicTitleLabel = UILabel()
    
    // 歌手名
    var singerLabel = UILabel()
    
    // 专辑
    var albumLabel = UILabel()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
       
        self.backgroundColor = UIColor.clear
        
        iconView = UIImageView()
        musicTitleLabel = UILabel()
        singerLabel = UILabel()
        albumLabel = UILabel()
        
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(musicTitleLabel)
        self.contentView.addSubview(singerLabel)
//        self.contentView.addSubview(albumLabel)

        
        iconView.image = UIImage(named: "ting移动@2x.jpg")
        iconView.layer.cornerRadius = 75 * 0.5
        iconView.layer.masksToBounds = true
        
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(10)
            make.width.equalTo(75)
            make.height.equalTo(75)

        }
     
//        musicTitleLabel.backgroundColor = UIColor.red
        musicTitleLabel.textColor = UIColor.orange
        musicTitleLabel.font = UIFont.systemFont(ofSize: 16)
//        musicTitleLabel.text = "哈哈哈哈啊啊"

        musicTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconView.snp.top).offset(5)
            make.left.equalTo(self.iconView.snp.right).offset(20)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.height.equalTo(25)
        
        }
        
        
//        singerLabel.backgroundColor = UIColor.yellow
        singerLabel.text = "歌手"
        singerLabel.textColor = UIColor.orange
        singerLabel.font = UIFont.systemFont(ofSize: 13)
        
        singerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.musicTitleLabel.snp.bottom).offset(20)
            make.left.equalTo(self.iconView.snp.right).offset(20)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            
        }
        
//        albumLabel.isHidden = true
//        albumLabel.backgroundColor = UIColor.blue
//        albumLabel.textColor = UIColor.orange
//        albumLabel.font = UIFont.systemFont(ofSize: 13)
//        albumLabel.sizeToFit()
//    
//        
//        albumLabel.snp.makeConstraints { (make) in
//            make.centerY.equalTo(self.singerLabel.snp.centerY)
//            make.left.equalTo(self.singerLabel.snp.right).offset(10)
//            make.right.equalTo(self.contentView.snp.right).offset(-20)
//        }
        
    }
    
    func sendModel(model:OnLinePlayerDetailModel) {
        
        self.iconView.kf.setImage(with: URL.init(string: model.songPicRadio), placeholder: UIImage(named:"ting移动@2x.jpg"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
    
    
        musicTitleLabel.text = model.songName
        singerLabel.text = String(format: "%@ - %@", model.artistName,model.albumName)

        // 专辑名
//        albumLabel.text = model.albumName
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

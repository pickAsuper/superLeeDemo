//
//  QQDetailTopVIew.swift
//  sinaDemo
//
//  Created by admin on 2017/5/16.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQDetailTopVIew: UIView {

    // 关闭按钮
    var closeBtn = UIButton()
    
    // 中间歌曲名字的文本
    var midMusicTextLabel = UILabel()
    
    // 中间歌手的文本
    var songgerLabel = UILabel()
    
    
    // 更多按钮
    var moreBtn = UIButton()
    
    var volumeSlider = UISlider()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

       
        self.addSubview(moreBtn)
        self.addSubview(songgerLabel)
        self.addSubview(midMusicTextLabel)
        self.addSubview(closeBtn)
        self.addSubview(volumeSlider)
        
        
        closeBtn.setImage(UIImage(named:"back_9x16"), for:.normal)
        closeBtn.frame = CGRect(x: 8, y: 40, width: 40, height: 40)
//        closeBtn.backgroundColor = UIColor.yellow
        
        midMusicTextLabel.text = "超人不会飞"
        midMusicTextLabel.textAlignment = .center
//        midMusicTextLabel.backgroundColor = UIColor.cyan
        midMusicTextLabel.textColor = UIColor.white
      
    moreBtn.isHidden = true

        moreBtn.setImage(UIImage(named:"main_tab_more"), for: .normal)
        moreBtn.frame = CGRect(x: kScreenW - 40 - 15, y: 40, width: 40, height: 40)
        
        midMusicTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.top).offset(40)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(kScreenW - ( 40 + 15 + 10) * 2 )
            make.height.equalTo(20)
        }
        
        songgerLabel.text = "周杰伦"
//        songgerLabel.backgroundColor = UIColor.purple
        songgerLabel.textAlignment = .center
        songgerLabel.font = UIFont.systemFont(ofSize: 13)
        songgerLabel.textColor = UIColor.white
        songgerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(40 + 20 + 10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(kScreenW - ( 40 + 15 + 10) * 2 )
            make.height.equalTo(20)
        }
        
        
        volumeSlider.setThumbImage(UIImage(named:"playing_volumn_slide_sound_icon"), for: .normal)
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue  = 1.0
        volumeSlider.value = 0.5
        volumeSlider.minimumTrackTintColor = UIColor.green
        volumeSlider.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.bottom).offset(-10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(kScreenW - 200 )
            make.height.equalTo(20)
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

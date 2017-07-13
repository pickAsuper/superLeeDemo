//
//  LCOnLineBottomView.swift
//  sinaDemo
//
//  Created by super on 2017/5/20.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCOnLineBottomView: UIView {

    
    lazy var musicTimeLabel2 :UILabel = {
        
        let musicTimeLabel2 = UILabel()
        
        musicTimeLabel2.text = "00:00"
        musicTimeLabel2.textAlignment = .center
        musicTimeLabel2.font = UIFont.boldSystemFont(ofSize: 20)
        musicTimeLabel2.textColor = UIColor.orange
        musicTimeLabel2.sizeToFit()
        musicTimeLabel2.width = kScreenW
        
        return musicTimeLabel2
    }()
    
    
    // 水波View
    lazy var waterView : LCWaveView = {
        let waterView = LCWaveView(frame: CGRect(x: 0, y:self.height, width: kScreenW, height: 100), color: UIColor.orange)
        waterView.addOverView(oView: self.musicTimeLabel2)
        waterView.backgroundColor = UIColor.clear
        
        waterView.waveHeight = 10
        
        waterView.startWave()
        return waterView
        
    }()
    
    
    lazy var albumNameLabel :UILabel = {
        
        let albumNameLabel = UILabel()
        
        albumNameLabel.text = "专辑"
        albumNameLabel.textAlignment = .right
        albumNameLabel.font = UIFont.systemFont(ofSize: 14)
        albumNameLabel.textColor = UIColor.orange
        albumNameLabel.sizeToFit()
        
        return albumNameLabel
    }()
    
    lazy var singerLabel :UILabel = {
        
        let singerLabel = UILabel()
        
        singerLabel.text = "歌手"
        singerLabel.textAlignment = .right
        
        singerLabel.font = UIFont.systemFont(ofSize: 14)
        singerLabel.textColor = UIColor.orange
        singerLabel.sizeToFit()
        
        return singerLabel
    }()
    
    lazy var musicLabel :UILabel = {
        
        let musicLabel = UILabel()
        
        musicLabel.text = "歌曲"
        musicLabel.textAlignment = .right
        musicLabel.font = UIFont.boldSystemFont(ofSize: 30)
        musicLabel.textColor = UIColor.orange
        musicLabel.sizeToFit()
        
        return musicLabel
    }()
    
    
    lazy var musicTimeLabel :UILabel = {
        
        let musicTimeLabel = UILabel()
        
        musicTimeLabel.text = ""
        musicTimeLabel.textAlignment = .right
        musicTimeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        musicTimeLabel.textColor = UIColor.orange
        musicTimeLabel.sizeToFit()
        
        return musicTimeLabel
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear

        self.addSubview(waterView)
        self.addSubview(albumNameLabel)
        self.addSubview(singerLabel)
        self.addSubview(musicLabel)
        self.addSubview(musicTimeLabel)
        
        // singerLabel
        singerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            
        }
        
        albumNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.singerLabel.snp.bottom)
            make.right.equalTo(self.snp.right).offset(-20)
            make.left.equalTo(self.snp.left).offset(5)
        }
        musicLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.albumNameLabel.snp.bottom)
            make.right.equalTo(self.snp.right).offset(-20)
            make.left.equalTo(self.snp.left).offset(5)

        }
        musicTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.musicLabel.snp.bottom)
            make.right.equalTo(self.snp.right).offset(-20)
            make.left.equalTo(self.snp.left).offset(5)

        }
        
        waterView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.bottom)
            make.height.equalTo(100)
            make.left.equalTo(self.left)
            make.right.equalTo(self.right)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

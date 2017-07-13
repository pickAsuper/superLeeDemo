//
//  QQDetailBottomVIew.swift
//  sinaDemo
//
//  Created by admin on 2017/5/16.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQDetailBottomVIew: UIView {

      // 播放时长
      var costTimeLabel = UILabel()
    
      // 进度滑动条
      var progressSlider = UISlider()
    
      // 总时长
      var totalTimeLabel = UILabel()
    
      // 播放暂停按钮
      var playOrPauseBtn = UIButton()
    
    
      // 上一曲按钮
      var preMusicBtn = UIButton()
    
      // 下一曲按钮
      var nextMusic = UIButton()
    
      // 快退按钮
      var backwardBtn = UIButton()
   
      // 快进按钮
      var forwardBtn = UIButton()

    
     override init(frame: CGRect) {
        super.init(frame: frame)
        
         setupUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension QQDetailBottomVIew {
   
    func setupUI(){
    
        self.addSubview(costTimeLabel)
        self.addSubview(progressSlider)
        self.addSubview(totalTimeLabel)
        self.addSubview(playOrPauseBtn)
        
        self.addSubview(preMusicBtn)
        self.addSubview(nextMusic)
        self.addSubview(backwardBtn)
        self.addSubview(forwardBtn)
        
        // 进度条的位置
        progressSlider.value = 0
        progressSlider.minimumValue = 0.0
        progressSlider.maximumValue = 1.0
        progressSlider.minimumTrackTintColor = UIColor.green
        progressSlider.frame = CGRect(x: 80, y: 10, width: kScreenW - 160, height: 20)
        
        costTimeLabel.frame = CGRect(x: 10, y: 10, width: 60, height: 20)
        totalTimeLabel.frame = CGRect(x: kScreenW - 60 - 10, y: 10, width: 60, height: 20)
        
        costTimeLabel.text = "00:00"
        totalTimeLabel.text = "00:00"

        costTimeLabel.textColor = UIColor.lightText
        totalTimeLabel.textColor = UIColor.lightText
        
        costTimeLabel.font = UIFont.systemFont(ofSize: 13)
        totalTimeLabel.font = UIFont.systemFont(ofSize: 13)
        
        costTimeLabel.textAlignment  = .center
        totalTimeLabel.textAlignment = .center
        
        // 播放暂停 58 193 162
        playOrPauseBtn.setImage(UIImage(named:"player_btn_play_normal"), for: .normal)
        playOrPauseBtn.setImage(UIImage(named:"player_btn_pause_normal"), for: .selected)
        
        playOrPauseBtn.isSelected = true
        
        playOrPauseBtn.snp.makeConstraints { (make) in
           make.bottom.equalTo(self.snp.bottom).offset(-20)
           make.centerX.equalTo(self.snp.centerX)
           make.width.equalTo(64)
           make.height.equalTo(64)
        }
    
        // 快退
        backwardBtn.setImage(UIImage(named:"hp_player_progress_reverse"), for: .normal)
        backwardBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.playOrPauseBtn.snp.left).offset(-20)
            make.centerY.equalTo(self.playOrPauseBtn.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        

        // 快进
        forwardBtn.setImage(UIImage(named:"hp_player_progress_forword"), for: .normal)
        forwardBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.playOrPauseBtn.snp.right).offset(20)
            make.centerY.equalTo(self.playOrPauseBtn.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        
        // 上一曲
        preMusicBtn.setImage(UIImage(named:"player_btn_pre_normal"), for: .normal)

        preMusicBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.backwardBtn.snp.left).offset(-20)
            make.centerY.equalTo(self.playOrPauseBtn.snp.centerY)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        
       // 
        // 下一曲
        nextMusic.setImage(UIImage(named:"player_btn_next_normal"), for: .normal)

        nextMusic.snp.makeConstraints { (make) in
            make.left.equalTo(self.forwardBtn.snp.right).offset(20)
            make.centerY.equalTo(self.playOrPauseBtn.snp.centerY)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }

        
    }

}



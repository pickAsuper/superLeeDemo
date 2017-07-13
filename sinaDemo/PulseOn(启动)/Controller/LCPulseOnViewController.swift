//
//  LCPulseOnViewController.swift
//  sinaDemo
//
//  Created by super on 2017/5/17.
//  Copyright © 2017年 super. All rights reserved.
//  

import UIKit
import Foundation
import AVFoundation
import MediaPlayer
import AVKit


class LCPulseOnViewController: UIViewController {


    // 引导视频播放结束后的闭包
    var playFinishedMovie:( () -> ())
    
    fileprivate lazy var enterMainButton :UIButton = {
        let enterMainButton = UIButton()
      
        enterMainButton.frame = CGRect(x: 24, y: kScreenH - 32 - 48, width: kScreenW - 48, height: 48)
        enterMainButton.alpha = 0
        enterMainButton.layer.borderWidth = 1
        enterMainButton.layer.cornerRadius = 24
        enterMainButton.setTitle("进入应用", for: .normal)
        enterMainButton.layer.borderColor = UIColor.white.cgColor
        enterMainButton.addTarget(self, action: #selector(enterMainAction), for: .touchUpInside)
        
        UIView.animate(withDuration: 3.0, animations: { 
            enterMainButton.alpha = 1.0
        })
        
        return enterMainButton
    }()
    
    fileprivate lazy var moviePlayer : MPMoviePlayerController = {
        let player = MPMoviePlayerController()
        
        player.view.frame = self.view.bounds
        
        // 设置自动播放
        player.shouldAutoplay = true
        
        // 设置源类型
        player.movieSourceType = .file
        
        // 取消下面的控制视图: 快进/暂停等...
        player.controlStyle = .none
        
        
//        NotificationCenter.default.addObserver(self, selector: .playerDisplayChange, name: NSNotification.Name.MPMoviePlayerReadyForDisplayDidChange, object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: .playerFinished, name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: nil)
        
        return player
        
    }()

    
    init(playFinished: @escaping () -> ()) {
        self.playFinishedMovie = playFinished
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoPlayer()
    
    }
   
  

    
    func setupVideoPlayer(){
        self.view.backgroundColor  = UIColor.white
        
        
        guard let movieURL = Bundle.main.path(forResource:"qidong.mp4", ofType:nil) else {
            print("没有找到路径")
            return
        }
        
        moviePlayer.contentURL = URL(fileURLWithPath: movieURL)
        self.view.addSubview(self.moviePlayer.view)
        
        moviePlayer.view.alpha = 0
        UIView.animate(withDuration: 3) { 
            
            self.moviePlayer.view.alpha = 1
            self.moviePlayer.prepareToPlay()
            self.moviePlayer.play()
        }
        
       

        self.moviePlayer.view.addSubview(enterMainButton)

        
    }

    
    
   
    // 进入程序的按钮点击
    func enterMainAction() {
        
        playFinishedMovie()
        
    }
}



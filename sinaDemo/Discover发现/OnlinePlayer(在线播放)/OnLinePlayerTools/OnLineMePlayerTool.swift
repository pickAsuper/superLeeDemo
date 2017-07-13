//
//  OnLineMePlayerTool.swift
//  sinaDemo
//
//  Created by super on 2017/5/21.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import MediaPlayer
import AVKit

class OnLineMePlayerTool: NSObject {

    
    fileprivate lazy var moviePlayer : MPMoviePlayerController = {
        let player = MPMoviePlayerController()
//        player.view.frame = self.view.bounds
        
        // 设置自动播放
        player.shouldAutoplay = true
        
        // 设置源类型
//        player.movieSourceType = .file
        
        // 取消下面的控制视图: 快进/暂停等...
        player.controlStyle = .none
        
        
        //        NotificationCenter.default.addObserver(self, selector: .playerDisplayChange, name: NSNotification.Name.MPMoviePlayerReadyForDisplayDidChange, object: nil)
        //
        //        NotificationCenter.default.addObserver(self, selector: .playerFinished, name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: nil)
        
        return player
        
    }()

    func playWithUrl(_ urlString:String) {
      
        let url = URL(string: urlString)
        self.moviePlayer.contentURL = url
        
        self.moviePlayer.prepareToPlay()
        self.moviePlayer.play()
        
    
    }
   
    func playMusic(){
        self.moviePlayer.play()
    }
    func pauseMusic(){
      self.moviePlayer.pause()
    }
    
    func  playerCurrentPlaybackTime() ->TimeInterval {
      let time =  self.moviePlayer.currentPlaybackTime
        return time
    }
    
}

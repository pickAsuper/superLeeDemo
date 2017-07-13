//
//  QQMusicTool.swift
//  sinaDemo
//
//  Created by admin on 2017/5/15.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import AVFoundation


let kPlayFinishNotification = "playFinish"


class QQMusicTool: NSObject {

    // 播放器
    var player: AVAudioPlayer?
    
    var volume: Float = 1
    
    override init() {
        super.init()
        
        let session = AVAudioSession.sharedInstance()
        do {
          // 后台播放
         try session.setCategory(AVAudioSessionCategoryPlayback)
         try session.setActive(true)
       
        }catch{
            print(error)
            return
        }
    
    }
    
    
    // 搜索时间
    func seekToTime(_ time: TimeInterval) {
         player?.currentTime = time
    }
    
    // 播放音乐
    func playMusic(_ musicName: String?){
        guard let url = Bundle.main.url(forResource: musicName, withExtension: nil) else{ return }
        if player?.url == url {
            player?.play()
            return
        }
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
          
            player?.delegate = self
         
            // 设置可以速率播放
            player?.enableRate = true
            
            // 播放器预播放
            player?.prepareToPlay()
                
            // 音量的声音。标称范围从0.0到1.0
            player?.volume = volume
            
            //  播放器播放
            player?.play()
            
        }catch{
        
            print(error)
            return
        
        }
        
    }
    
    
    // 暂停音乐
    func pauseMusic() {
        player?.pause()
    }
    
    // 播放当前音乐
    func playCurrentMusic()  {
        player?.play()
    }
    
    // 停止当前音乐
    func stopCurrentMusic() {
        player?.currentTime = 0
        player?.stop()
    }
    
    // 快进 //1.0 is normal
    func fastforward(_ value:TimeInterval){
         player?.currentTime += value
    }
    
    // 快退
    func fastbackward(_ value:TimeInterval) {
        player?.currentTime -= value
    }
    
    // 播放器参数 rate : 看到enableRate。声音的回放速度。1.0是正常的,0.5是半速,2.0是速度的两倍
    func rate(_ value:Float) {
        player?.rate = value
    }
    
    // 设置声音
    func volume(_ value: Float){
        volume = value
        player?.volume = volume
    }
    
    
}

extension QQMusicTool: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        // 播放完成的通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:kPlayFinishNotification), object: nil)
    
    }

}



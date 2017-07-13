//
//  OnLinePlayerMusicTool.swift
//  sinaDemo
//
//  Created by super on 2017/5/20.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import AVFoundation
import MediaPlayer
import AVKit

class OnLinePlayerMusicTool: NSObject {
    
        // 播放器
        var player: AVAudioPlayer?
    
    var player2 : AVAudioPlayer = {
    let player2 = AVAudioPlayer()
        
    
    return player2
    }()
    
    
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


            let url = URL(string: musicName!)
//            let audioData = NSData(contentsOf: url!)
//            
//        
//          let docDirPath =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//            
//            
//            let filePath = docDirPath[0] + "/" + musicName! + ".mp3"
//
//
//            print(audioData)
//          
//            print(filePath)
//
//            audioData?.write(toFile: filePath, atomically: true)
//        
////           let error = Error;
//            
//           let urlPath = URL(fileURLWithPath: filePath)
//            
//            print(urlPath)
            
            
            

            if player?.url == url {
                player?.play()
                return
            }
            
            do{
                
                
                self.player = try AVAudioPlayer(contentsOf: url!)
              
                print(self.player2)

                self.player?.delegate = self
                
                // 设置可以速率播放
                self.player?.enableRate = true
                
                // 播放器预播放
                self.player?.prepareToPlay()
                
                // 音量的声音。标称范围从0.0到1.0
                self.player?.volume = volume
                
                //  播放器播放
                self.player?.play()
                
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
        
    
        deinit {
            print(self.player)
        }
    
    }
    

extension OnLinePlayerMusicTool: AVAudioPlayerDelegate {
        
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            
            // 播放完成的通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:kPlayFinishNotification), object: nil)
            
        }
        
}

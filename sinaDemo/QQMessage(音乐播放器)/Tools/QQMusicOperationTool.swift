//
//  QQMusicOperationTool.swift
//  sinaDemo
//
//  Created by admin on 2017/5/15.
//  Copyright © 2017年 super. All rights reserved.


//  QQ音乐操作的工具  -> 调用 播放器工具类 QQMusicTool

import UIKit
import MediaPlayer


class QQMusicOperationTool: NSObject {

    static let shareInstance = QQMusicOperationTool()
    
    let tool = QQMusicTool()
    
    var musicMs: [QQMusicModel] = [QQMusicModel]()
    
    fileprivate var lastRow = -1
    
    // MPMediaItemArtwork IOS锁屏状态播放音乐时显示专辑信息和图片 
    fileprivate var artWork :MPMediaItemArtwork?
    
    fileprivate var currentPlayIndex = -1 {
        didSet {
            if currentPlayIndex < 0{
                currentPlayIndex = (musicMs.count) - 1
                
            }
            if currentPlayIndex > (musicMs.count) - 1 {
                currentPlayIndex = 0
            }
        
        }
    
    }
    
    // 歌曲信息
    fileprivate var musicMessageM = QQMusicMessageModel()
    func getMusicMessageModel() -> QQMusicMessageModel {
        
        if musicMs == nil {
            return musicMessageM
        }
        musicMessageM.musicM = musicMs[currentPlayIndex]
        musicMessageM.costTime = (tool.player?.currentTime) ?? 0
        musicMessageM.totalTime = (tool.player?.duration) ?? 0
        musicMessageM.isPlaying = (tool.player?.isPlaying) ?? false
        return musicMessageM
        
    }
    
    
    // 播放音乐 把 歌曲文件扔进去 把歌曲对应的模型扔进去
    func playMusic(_ musicM: QQMusicModel){
      

        tool.playMusic(musicM.filename)
        
        // 当前下标
        currentPlayIndex = musicMs.index(of: musicM)!
        
    }
    // LCOnLinePlayerInterfaceController
    // Play interface
    // 播放当前的音乐
    func playCurrentMusic() {
        
        // 把当前的歌曲扔进去 播放
        let model = musicMs[currentPlayIndex]
         playMusic(model)
        
    }
    
    // 暂停当前歌曲
    func pauseCurrentMusic(){
          tool.pauseMusic()
    }
    
    // 下一曲
    func nextMusic() {
        currentPlayIndex += 1
        let model = musicMs[currentPlayIndex]
        playMusic(model)
    
    }
    
    // 上一曲
    func preMusic() {
        currentPlayIndex -= 1
        let model = musicMs[currentPlayIndex]
        playMusic(model)
    }
    
    func seekToTime(_ time: TimeInterval){
         tool.seekToTime(time)
    }
    
    // 快进
    func forward(_ time:TimeInterval) {
        tool.fastforward(time)
    }
    
    // 快进10秒
    func forward() {
        tool.fastforward(10)
    }
    
     // 快退10秒
    func backward() {
        tool.fastbackward(10)
    }
    
    // 设置声音大小
    func volume(_ value : Float)  {
        tool.volume(value)
    }
    
    
    // 设置锁屏信息
    func setupLockMessage(){
     
       // 获取歌曲信息
       let musicMessageM = getMusicMessageModel()
    
        // 正在播放的信息 ->系统单例
       let center = MPNowPlayingInfoCenter.default()
      
        // 如果musicMessageM.musicM?.name 为空 就用 空值 ?? -> 前一个没值就用后面的值
        // 获取歌曲名
        let musicName = musicMessageM.musicM?.name ?? ""
    
        // 获取歌手名
        let singerName = musicMessageM.musicM?.singer ?? ""
    
        let costTime = musicMessageM.costTime
       
        let totalTime = musicMessageM.totalTime
        
        let lrcFileName = musicMessageM.musicM?.lrcname
        
        let lrcMs = QQMusicDataTool.getLrcMs(lrcFileName)
        
        // 获取当前歌词列表 获取当前歌词的模型
        let lrcModelAndRow = QQMusicDataTool.getCurrentLrcM(musicMessageM.costTime, lrcMs: lrcMs)
        
        let lrcM = lrcModelAndRow.lrcM
        
        var resultImage : UIImage?
        
        if lastRow != lrcModelAndRow.row {
         
            lastRow = lrcModelAndRow.row
            resultImage = QQImageTool.getNewImage(UIImage(named:musicMessageM.musicM?.icon ?? ""), str: lrcM?.lrcContent)
           
            if resultImage != nil {
               artWork = MPMediaItemArtwork(image: resultImage!)
                
            }
        }
        
        // 设置一堆有关于锁屏播放的数据 -> 歌名/歌手/总时长/播放时长
        let dic : NSMutableDictionary = [
            MPMediaItemPropertyAlbumTitle:musicName,
            MPMediaItemPropertyArtist:singerName,
            MPMediaItemPropertyPlaybackDuration : totalTime,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: costTime
        ]
        
        if artWork != nil {
           dic.setValue(artWork!, forKey: MPMediaItemPropertyArtwork)
        }
        
            let dicCopy = dic.copy()
            center.nowPlayingInfo = dicCopy as? [String : Any]
            UIApplication.shared.beginReceivingRemoteControlEvents()
        
    }
    
    
}





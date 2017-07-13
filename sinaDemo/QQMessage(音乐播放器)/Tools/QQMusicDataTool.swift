//
//  QQMusicDataTool.swift
//  sinaDemo
//
//  Created by admin on 2017/5/12.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQMusicDataTool: NSObject {

    
    class func getMusicMs(_ result: ([QQMusicModel])->()) {
        // 获取本地的音乐列表
        guard let path = Bundle.main.path(forResource: "Musics.plist", ofType: nil) else {
            result([QQMusicModel]())
            return
        }
     
        // 把文件路径加载到数组
        guard let array = NSArray(contentsOfFile: path) else {
            result([QQMusicModel]())
            return
        }
        
        // 传给模型
        var musicMs  = [QQMusicModel]()
        for dic in array {
            let musicM = QQMusicModel(dict: dic as! [String : Any])
            musicMs.append(musicM)
        }
        result(musicMs)
        
    }
    
    class func getLrcMs(_ lrcName : String?) -> [QQLrcModel] {
        
        if lrcName == nil {
            return [QQLrcModel]()
        }
        
        
        guard let path = Bundle.main.path(forResource: lrcName, ofType: nil) else { return [QQLrcModel]() }
        
        
        var lrcContent = ""
        
        do{
            lrcContent = try String(contentsOfFile: path)
            
        }catch {
        
            print(error)
            return [QQLrcModel]()
        
        }
        
        let timeContentArray = lrcContent.components(separatedBy: "\n")
        var lrcMs = [QQLrcModel]()
        for  timeContentStr in timeContentArray {
           
            // 如果字符串包含就 继续
            if timeContentStr.contains("[ti:") || timeContentStr.contains("[ar:") || timeContentStr.contains("[al:") { continue }
          
            // replacingOccurrences 方法用来实现子字符串的替换，并返回一个新的字符串
            let resultLrcStr = timeContentStr.replacingOccurrences(of: "[", with: "")
            
            // 时间和内容字符
            let timeAndContent = resultLrcStr.components(separatedBy: "]")
            
            if timeAndContent.count != 2 { continue }
            
            // 取出时间
            let time = timeAndContent[0]
            
            // 取出内容
            let content = timeAndContent[1]
 
            let lrcM = QQLrcModel()
            
            // 把时间传给 (时间工具) 返回一个 TimeInterval
            lrcM.beginTime = QQTimeTool.getTimeInterval(time)
            lrcM.lrcContent = content
            lrcMs.append(lrcM)
        
        }
        
        for i in 0..<lrcMs.count {
            if i == lrcMs.count - 1  { break }
            lrcMs[i].endTime = lrcMs[i + 1].beginTime
        }

        return lrcMs
    }
    
    // 获取当前歌词列表
    class func getCurrentLrcM(_ currentTime: TimeInterval, lrcMs: [QQLrcModel]) ->(row: Int,lrcM:QQLrcModel?) {
       
        for i in 0..<lrcMs.count {
            
            if currentTime >= lrcMs[i].beginTime && currentTime < lrcMs[i].endTime {
                return (i , lrcMs[i])
            }
        }
        return (0 , nil)
    }
}

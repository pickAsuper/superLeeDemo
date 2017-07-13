//
//  LCOnLinePlayerInterfaceController.swift
//  sinaDemo
//
//  Created by super on 2017/5/19.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

import AVFoundation
import Foundation
import AVFoundation
import MediaPlayer
import AVKit
class LCOnLinePlayerInterfaceController: UIViewController {
   
    let t = OnLinePlayerMusicTool()
  let tools =  OnLineMePlayerTool()
   
    // 歌词列表控制器的懒加载
    lazy var lrcVC: QQLrcTVC = {
    
        return QQLrcTVC()
    }()
    
    // 播放器
    var player: AVAudioPlayer?
    
    lazy var listModel    = OnLinePlayerDetailModel(dict: "")
    
    var displayTimeView   = LCOnLineDisplayTimeView()
    var displayBottomView = LCOnLineBottomView()

    var visualEffectView : UIVisualEffectView = {
        // 毛玻璃效果
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
        visualEffectView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        visualEffectView.isUserInteractionEnabled = true
        return visualEffectView
        
     }()
    
    fileprivate var updateLrcLink: CADisplayLink?

    // 更新时间
    fileprivate var updateTimesTimer: Timer?

    // 底层大的背景View
    var backImageView = UIImageView()
    
    
    // 前部的图片
    var foreImageView = UIImageView()
    
    
    // 底部的View
    lazy var bottomView :LCOnLinePlayerActionView = {
        
        let bottomView = LCOnLinePlayerActionView()
            bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return bottomView
    }()
  
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addTimes()
     
        loadMusicListData()
        
        setupUI()
       
    }

    // 释放
    deinit {
        updateTimesTimer?.invalidate()
        updateLrcLink?.invalidate()
        updateLrcLink = nil
        
    }
   
}


// MARK - setupUI
extension LCOnLinePlayerInterfaceController {

    func setupUI() {
       
        self.view.backgroundColor = UIColor.rgba(red: 84, green: 70, blue: 58, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_ :)))
        foreImageView.addGestureRecognizer(tap)
        
        foreImageView.isUserInteractionEnabled = true
        foreImageView.kf.setImage(with: URL.init(string: listModel.songPicRadio), placeholder: UIImage(named:"screen696x696@2x.jpg"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        // 大的背景图
        backImageView.kf.setImage(with: URL.init(string: listModel.songPicRadio), placeholder: UIImage(named:"screen696x696@2x.jpg"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        
        backImageView.isUserInteractionEnabled = true
        backImageView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        view.addSubview(backImageView)
        
        bottomView.playBtn.addTarget(self, action: #selector(playBtnClick(_ :)), for: .touchUpInside)
        // 添加毛玻璃效果层
        backImageView.addSubview(visualEffectView)
        
        
        self.view.addSubview(displayTimeView)
        self.view.addSubview(displayBottomView)
        self.view.addSubview(foreImageView)
        self.view.addSubview(bottomView)
      
        displayBottomView.albumNameLabel.text = self.listModel.albumName
        displayBottomView.singerLabel.text = self.listModel.artistName
        displayBottomView.musicLabel.text = self.listModel.songName

        displayTimeView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(180)
        }
        
        foreImageView.snp.makeConstraints { (make) in
            make.top.equalTo(displayTimeView.snp.bottom)
            make.left.equalTo(20)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        displayBottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.foreImageView.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom).offset(-60)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom)
            make.width.equalTo(kScreenW)
            make.height.equalTo(60)
        }
        
       
        self.view.addSubview(lrcVC.tableView)
        let touchTop = UITapGestureRecognizer(target: self, action: #selector(touchesAndTap(_:)))
         lrcVC.tableView.addGestureRecognizer(touchTop)
        lrcVC.tableView.backgroundColor = UIColor.clear
        lrcVC.tableView.delegate = self
        lrcVC.tableView.isHidden = true

    }

    
}
// MAKE - 获取歌曲数据
extension LCOnLinePlayerInterfaceController {
    
    func loadMusicListData(){
    
        let params = ["songIds":self.listModel.songId]
        
        NetRequest.shareInstance.postRequest(urlString: "http://fm.baidu.com/data/music/songlink", params: params) { (response, error) in
            
            if response == nil{
                return
            }

            
            let json = JSON(response!)

            
            for(_,subJosn):(String,JSON) in json["data"]["songList"] {
               
                let model = OnLineMusicModel.init(dict: subJosn)
                
                self.tools.playWithUrl(model.songLink)
               
                AFNetworkingTool.shared.get(model.lrcLink, parameters:nil, progress: nil, success: { (task, res) in

                    let data:Data = res as! Data

                    let dataStr = String.init(data: data, encoding: String.Encoding.utf8)
        
                    let time = model.time
                    

                    self.lrcVC.lrcMs = OnLineLrcListDataTool.getLrcMs(dataStr)
                    let rowLrcM = OnLineLrcListDataTool.getCurrentLrcM(TimeInterval(time), lrcMs: self.lrcVC.lrcMs)

                    
                    
//                    QQMusicOperationTool.shareInstance.playMusic()

                    self.displayBottomView.musicTimeLabel.text  = String(format: "%.02f minute",CGFloat(model.time) / 60.0)
                    
                    
                    self.lrcVC.scrollRow = rowLrcM.row

                    
                }, failure: { (task, error) in
                    
                    print(error)
                    
                    
                })
                

                
                
//               self.listArray.append(model)
//                self.t.playMusic("http://yinyueshiting.baidu.com/data2/music/124110605/13942427212400128.mp3?xcode=f7c5c8aea428eb696f333bb99c6701d9")
//                self.t.volume = 1.0
                
            }
            
            
        }
        
    }

}

// MAKE - 点击事件
extension LCOnLinePlayerInterfaceController {

    func playBtnClick(_ sender:UIButton){
         sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.tools.playMusic()
            
        }else{
            self.tools.pauseMusic()
        
        }
    
    
    }
    
    func touchesAndTap(_  tap : UITapGestureRecognizer){
    
        lrcVC.tableView.isHidden = true
        bottomView.isHidden = false
        displayBottomView.isHidden = false
       

    }
    
    
    // 前景图片的点击时间
    func tapGesture(_ tap:UITapGestureRecognizer){

//        lrcVC.tableView.backgroundView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
        lrcVC.tableView.backgroundView = UIImageView(image: UIImage(named:"歌词背景图片@2x.jpg"))

        displayBottomView.isHidden = true
        bottomView.isHidden = true
        lrcVC.tableView.isHidden = false

        lrcVC.tableView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        })
       

        
    
    }


}


// MARK - 更新时间
extension LCOnLinePlayerInterfaceController {

    func addLink() {
        updateLrcLink = CADisplayLink(target: self, selector: #selector(QQDetailVC.updateLrc))
        updateLrcLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    // 添加timer
    func addTimes() {
        
        updateTimesTimer = Timer(timeInterval: 1, target: self, selector: #selector(LCOnLinePlayerInterfaceController.changeTimes), userInfo: nil, repeats: true)
        RunLoop.current.add(updateTimesTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    func changeTimes(){
        let currentDate = Date()
        let dateFormatter  = DateFormatter()
        
        // 设置本地时区
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let stringDate = dateFormatter.string(from: currentDate)
        
        displayTimeView.timeLabel.text = stringDate
        
        
        let times = self.tools.playerCurrentPlaybackTime()
        
        let date = Date(timeIntervalSince1970: times)
        
        let formatter = dateFormatter
        formatter.dateFormat = "mm:ss"
        
        
       let timeString =  String(format: "%@", formatter.string(from: date))
        
        displayBottomView.musicTimeLabel2.text = timeString
        
    }


}


extension LCOnLinePlayerInterfaceController :UITableViewDelegate {
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let radio = 1 - scrollView.contentOffset.y / scrollView.height
        print(radio)
        
//        middleView.foreImageView.alpha = radio
//        middleView.lrcLabel.alpha = radio
    }

}


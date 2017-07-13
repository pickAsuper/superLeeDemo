//
//  QQDetailVC.swift
//  sinaDemo
//
//  Created by admin on 2017/5/16.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import JXPhotoBrowser

class QQDetailVC: UIViewController {
    fileprivate var browser: LLPhotoBrowserViewController?

    // 背景图大小
    var backImageView = UIImageView()
    
    // 顶部的View
    var topView = QQDetailTopVIew()
    
    // 中间的View 
    var middleView = QQDetailMiddleVIew()
    
    // 底部的View 
    var bottomView = QQDetailBottomVIew()
    
    
    lazy var bigImageArray = [String]()

    // 歌词列表控制器的懒加载
    lazy var lrcVC: QQLrcTVC = {
        return QQLrcTVC()
    }()
    lazy var messageTableViewVC: QQMessageTableViewController = {
        return QQMessageTableViewController()
    }()
    
    // 更新时间
    fileprivate var updateTimesTimer: Timer?
   
    //  http://www.jianshu.com/p/c35a81c3b9eb CADisplayLink详解
    //  CADisplayLink在正常情况下会在每次刷新结束都被调用，精确度相当高
    // 定时器
    fileprivate var updateLrcLink: CADisplayLink?

    
    
    var closeBtn = UIButton()
    
    
    deinit{
        // 移除通知
        NotificationCenter.default.removeObserver(self)
    
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(QQDetailVC.nextMusic), name: NSNotification.Name(rawValue: kPlayFinishNotification), object: nil)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateOnce()
        addTimes()
        addLink()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        removeTimer()
        removeLink()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
//        messageTableViewVC.tableView.frame  =  middleView.lrcScrollView.bounds
//        messageTableViewVC.tableView.x = (middleView.lrcScrollView.width * 2)
        
        lrcVC.tableView.frame = middleView.lrcScrollView.bounds
        lrcVC.tableView.x = middleView.lrcScrollView.width
        middleView.lrcScrollView.contentSize = CGSize(width: middleView.lrcScrollView.width * 2, height: 0)

        
    }

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {//摇一摇
        QQMusicOperationTool.shareInstance.nextMusic()
        updateOnce()
    }

    
}

extension QQDetailVC {
 
    func setupUI() {
       
        // 大的背景图
        backImageView.image = UIImage(named: "jay.jpg")
        backImageView.isUserInteractionEnabled = true
        backImageView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        view.addSubview(backImageView)
        
        // 毛玻璃效果
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
        visualEffectView.frame = backImageView.frame
        visualEffectView.isUserInteractionEnabled = true
        //添加毛玻璃效果层
        backImageView.addSubview(visualEffectView)
        
        
        // 顶部按钮
        topView = QQDetailTopVIew()
        topView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 125)
        view.addSubview(topView)
       
        // 关闭按钮的点击事件
        topView.closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        
        topView.volumeSlider.addTarget(self, action: #selector(volume(_ :)), for: .valueChanged)
        topView.moreBtn.addTarget(self, action: #selector(moreBtnClick), for: .valueChanged)

        
        
        
        bottomView = QQDetailBottomVIew()
        bottomView.frame = CGRect(x: 0, y: kScreenH - 130, width: kScreenW, height: 130)
        view.addSubview(bottomView)
        bottomView.progressSlider.addTarget(self, action: #selector(touchDown), for: .touchDown)
        bottomView.progressSlider.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        bottomView.progressSlider.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        
        // 播放暂停
        bottomView.playOrPauseBtn.addTarget(self, action: #selector(playOrPause(_ :)), for: .touchUpInside)
        
        // 上一曲按钮
        bottomView.preMusicBtn.addTarget(self, action: #selector(preMusic), for: .touchUpInside)
        bottomView.nextMusic.addTarget(self, action: #selector(nextMusic), for: .touchUpInside)
        bottomView.forwardBtn.addTarget(self, action: #selector(forward), for: .touchUpInside)
        bottomView.backwardBtn.addTarget(self, action: #selector(backward), for: .touchUpInside)

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_ :)))
        bottomView.progressSlider.addGestureRecognizer(tapGestureRecognizer)
        
        middleView = QQDetailMiddleVIew()
        middleView.frame = CGRect(x: 0, y: topView.height, width: kScreenW, height: kScreenH - topView.height - bottomView.height)
        view.addSubview(middleView)
      

        middleView.lrcScrollView.addSubview(lrcVC.tableView)
//        middleView.lrcScrollView.addSubview(messageTableViewVC.tableView)

        middleView.lrcScrollView.delegate = self
        middleView.lrcScrollView.isPagingEnabled = true
        middleView.lrcScrollView.showsHorizontalScrollIndicator = false
        
        bottomView.progressSlider.setThumbImage(UIImage(named:"player_slider_playback_thumb"), for: .normal)
        topView.volumeSlider.setThumbImage(UIImage(named: "playing_volumn_slide_sound_icon"), for: UIControlState())

       
        middleView.amazingBtn.addTarget(self, action: #selector(amazingBtnClick), for: .touchUpInside)
        
        
    }
    
 
}

extension QQDetailVC {
   
    
    // 前面展示的图片的点击事件
    func amazingBtnClick() {
        
        bigImageArray.removeAll()
        
        let musicMessageM = QQMusicOperationTool.shareInstance.getMusicMessageModel()
        
        guard let musicM = musicMessageM.musicM else { return }
        
        // 更新大的背景图和前面的图片
        if musicM.icon != nil {
            backImageView.image = UIImage(named: (musicM.icon)!)
            middleView.foreImageView.image = UIImage(named: (musicM.icon)!)
        }

        bigImageArray.append(musicM.icon!)
        
        
        let bigPictureVC =  LCBigPictureViewController()
       
        bigPictureVC.bigImageArray = bigImageArray

        self.present(bigPictureVC, animated: false, completion: nil)
        
      
    }
    
    
    // 关闭按钮
    func  closeBtnClick()  {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

    // 音量控制滑动改变
    func volume(_ sender:UISlider) {
        QQMusicOperationTool.shareInstance.volume(sender.value)
    }
  
    func moreBtnClick(){
      
        
    
    }
    
    
    // 底部滑动条的各个事件
    func touchDown() {
       removeTimer()
    }
    
    func touchUp() {
        addTimes()
        let costTime = QQMusicOperationTool.shareInstance.getMusicMessageModel().totalTime * TimeInterval(bottomView.progressSlider.value)
        // 跳到指定时间点播放
        QQMusicOperationTool.shareInstance.seekToTime(costTime)
        
    }
    
    func valueChange() {
        let costTime = QQMusicOperationTool.shareInstance.getMusicMessageModel().totalTime * TimeInterval(bottomView.progressSlider.value)
        bottomView.costTimeLabel.text = QQTimeTool.getFormatTime(costTime)
    }
    
    func tap(_ sender:UITapGestureRecognizer) {
        
        // 计算点击了那个位置
        let value = sender.location(in: sender.view).x / (sender.view?.width)!
        
        bottomView.progressSlider.value = Float(value)
        let totalTime = QQMusicOperationTool.shareInstance.getMusicMessageModel().totalTime
        let costTime = totalTime * TimeInterval(value)
        
        // 寻找播放歌曲的对应时间
        QQMusicOperationTool.shareInstance.seekToTime(costTime)
    }
    
    // 播放暂停按钮点击事件
    func playOrPause(_ sender:UIButton)  {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
          QQMusicOperationTool.shareInstance.playCurrentMusic()
            middleView.foreImageView.layer.resumeAnimate()
        }else{
            QQMusicOperationTool.shareInstance.pauseCurrentMusic()
            middleView.foreImageView.layer.pauseAnimate()
        }
    }
   
    // 上一曲按钮点击事件
    func preMusic() {
     QQMusicOperationTool.shareInstance.preMusic()
      updateOnce()
    }
   
    // 下一曲按钮点击事件
    func nextMusic(){
        QQMusicOperationTool.shareInstance.nextMusic()
        updateOnce()
    }
    
    // 快进点击事件
    func  forward()  {
        QQMusicOperationTool.shareInstance.forward()
    }
    // 快进退点击事件
    func  backward()  {
        QQMusicOperationTool.shareInstance.backward()
    }
}

extension QQDetailVC:UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let radio = 1 - scrollView.contentOffset.x / scrollView.width
        middleView.foreImageView.alpha = radio
        middleView.lrcLabel.alpha = radio
    }

}


extension QQDetailVC {
   
    // 添加timer
    func addTimes() {

        updateTimesTimer = Timer(timeInterval: 1, target: self, selector: #selector(QQDetailVC.updateTimes), userInfo: nil, repeats: true)
        RunLoop.current.add(updateTimesTimer!, forMode: RunLoopMode.commonModes)
        
    }

    // 移除时间器
    func removeTimer() {
        updateTimesTimer?.invalidate()
        updateTimesTimer = nil
    }
    
    
    // 更新播放时间
    func updateTimes()  {
        let musicMessageM = QQMusicOperationTool.shareInstance.getMusicMessageModel()
        bottomView.progressSlider.value = Float(musicMessageM.costTime / musicMessageM.totalTime)
        
        print("aaaa+ \(musicMessageM.costTimeFormat)")
        
        bottomView.costTimeLabel.text = musicMessageM.costTimeFormat
        bottomView.playOrPauseBtn.isSelected = musicMessageM.isPlaying
        
    }
    
    func addLink() {
        updateLrcLink = CADisplayLink(target: self, selector: #selector(QQDetailVC.updateLrc))
        updateLrcLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    func removeLink() {
        updateLrcLink?.invalidate()
        updateLrcLink = nil
    }
    
    // UISlider的播放进度更新，频率比updateLrc低
    func updateLrc() {
        let musicMessageM = QQMusicOperationTool.shareInstance.getMusicMessageModel()
        let time = musicMessageM.costTime
        let rowLrcM = QQMusicDataTool.getCurrentLrcM(time, lrcMs: lrcVC.lrcMs)
        let lrcM = rowLrcM.lrcM
        
        // 更新歌词，固定的单行歌词
        middleView.lrcLabel.text = lrcM?.lrcContent
        
        if lrcM != nil {
            middleView.lrcLabel.radio = CGFloat((time - lrcM!.beginTime) / (lrcM!.endTime - lrcM!.beginTime))
            lrcVC.progress =  middleView.lrcLabel.radio
        }
    
        //lrcVC 流动整屏时用到的位置行
        lrcVC.scrollRow = rowLrcM.row
        
        if UIApplication.shared.applicationState == .background {
            // 更新锁屏界面信息
            QQMusicOperationTool.shareInstance.setupLockMessage()
            
        }
    
    }

    // 第一次进来 下一曲或上一曲 都更新播放信息
    func updateOnce() {
    
       let musicMessageM = QQMusicOperationTool.shareInstance.getMusicMessageModel()
        
        guard let musicM = musicMessageM.musicM else { return }
        
        // 更新大的背景图和前面的图片
        if musicM.icon != nil {
            backImageView.image = UIImage(named: (musicM.icon)!)
            middleView.foreImageView.image = UIImage(named: (musicM.icon)!)
        }
        
        // 顶部的歌曲 和 歌手 音量大小
        topView.midMusicTextLabel.text = musicM.name
        topView.songgerLabel.text = musicM.singer
        topView.volumeSlider.value = (QQMusicOperationTool.shareInstance.tool.volume)
        
        // 底部的总时长
        bottomView.totalTimeLabel.text = musicMessageM.totalTimeFormat
        
        // 交由歌词控制器来展示
        lrcVC.lrcMs = QQMusicDataTool.getLrcMs(musicM.lrcname)
        
        // 大图(middleView.foreImageView)选择
        middleView.foreImageView.layer.removeAnimation(forKey: "rotation")
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.duration = 30
        animation.isRemovedOnCompletion = false
        animation.repeatCount = MAXFLOAT
        middleView.foreImageView.layer.add(animation, forKey: "rotation")
        
        // 播放的时候旋转
        if musicMessageM.isPlaying {
            middleView.foreImageView.layer.resumeAnimate()
        }else {
            middleView.foreImageView.layer.pauseAnimate()
        }
        
    }
    
    
}


extension QQDetailVC {
    // 远程事件
    override func remoteControlReceived(with event: UIEvent?) {
        switch (event?.subtype)! {
        case .remoteControlPlay:
            QQMusicOperationTool.shareInstance.playCurrentMusic()
        case .remoteControlPause:
            QQMusicOperationTool.shareInstance.pauseCurrentMusic()
        case .remoteControlNextTrack:
            QQMusicOperationTool.shareInstance.nextMusic()
        case .remoteControlPreviousTrack:
            QQMusicOperationTool.shareInstance.preMusic()
        default:
            print("....")
        }
        
        // 得更新歌曲信息
          updateOnce()
    }



}




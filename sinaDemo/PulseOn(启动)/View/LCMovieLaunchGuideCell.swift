//
//  LCMovieLaunchGuideCell.swift
//  sinaDemo
//
//  Created by admin on 2017/5/18.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import MediaPlayer
class LCMovieLaunchGuideCell: UICollectionViewCell {
    
    
    fileprivate lazy var moviePlayer : MPMoviePlayerController = {
       let player = MPMoviePlayerController()
        
            player.view.frame = self.contentView.bounds
            
            // 设置自动播放
            player.shouldAutoplay = true
            
            // 设置源类型
            player.movieSourceType = .file
            
            // 取消下面的控制视图: 快进/暂停等...
            player.controlStyle = .none
        
      
        NotificationCenter.default.addObserver(self, selector: .playerDisplayChange, name: NSNotification.Name.MPMoviePlayerReadyForDisplayDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: .playerFinished, name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: nil)
        
        
        
        return player
    
    }()
    
    fileprivate lazy var imageView : UIImageView = {
      let imageView = UIImageView(frame:self.moviePlayer.view.bounds)
        return imageView
    }()
    
    var coverImage : UIImage?{
        didSet{
            if let _ = coverImage {
                imageView.image = coverImage
            }
        }
    }
    
    
    var moviePath : String?{
        didSet{
            if let path = moviePath{
              moviePlayer.contentURL = URL(fileURLWithPath: path ,isDirectory: false)
                
                moviePlayer.prepareToPlay()
                
            }
        
        }
    
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(moviePlayer.view)
        moviePlayer.view.addSubview(imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playerDisplayChange() {
        if moviePlayer.readyForDisplay {
            moviePlayer.backgroundView.addSubview(imageView)
        }

    }
    
    func playFinished() {
       NotificationCenter.default.post(name: NSNotification.Name("PlayFinishedNotify"), object: nil)
    }
    
}


private extension Selector {

    static let playerDisplayChange = #selector(LCMovieLaunchGuideCell.playerDisplayChange)
    static let playerFinished = #selector(LCMovieLaunchGuideCell.playFinished)
    

}

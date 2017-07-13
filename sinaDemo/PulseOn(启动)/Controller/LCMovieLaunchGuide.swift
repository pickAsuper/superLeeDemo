//
//  LCMovieLaunchGuide.swift
//  sinaDemo
//
//  Created by admin on 2017/5/18.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

private let LCMovieLaunchGuideCellID = "LCMovieLaunchGuideCellID"

class LCMovieLaunchGuide: UIViewController {

    var collectionView : UICollectionView!

    // 图片数组
    var guideImages: [UIImage]
    
    // 视频数组
    var guideMoviePaths: [String]
    
    
    // 引导视频播放结束后的闭包
    var playFinished:( () -> ())
    
    var pageControl : UIPageControl!
    
    fileprivate var isMovieFinished = false
    
    init(guideImages: [UIImage] ,guideMoviePaths: [String] , playFinished: @escaping () -> ()) {
        
        self.guideImages = guideImages
        self.guideMoviePaths = guideMoviePaths
        self.playFinished = playFinished
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pageControl.numberOfPages = guideMoviePaths.count
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

}

extension LCMovieLaunchGuide {
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: kScreenH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        // 允许横着滚动
        layout.scrollDirection = . horizontal
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(LCMovieLaunchGuideCell.self, forCellWithReuseIdentifier: LCMovieLaunchGuideCellID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    
        let width: CGFloat = 120.0
        let height: CGFloat = 30.0
        let x:CGFloat = (kScreenW - width) * 0.5
        let y:CGFloat = kScreenH - 30 - 20
        pageControl = UIPageControl(frame: CGRect(x: x, y: y, width: width, height: height))
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        view.addSubview(pageControl)
        
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlay), name: NSNotification.Name(rawValue: "PlayFinishedNotify"), object: nil)
        
        
        
    }
    
    func finishedPlay()  {
        isMovieFinished = true
    }


}


extension LCMovieLaunchGuide : UICollectionViewDelegate,UICollectionViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / collectionView.bounds.width + 0.5)
            pageControl.currentPage = page
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guideMoviePaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LCMovieLaunchGuideCellID, for: indexPath) as! LCMovieLaunchGuideCell
        
        cell.coverImage = guideImages[indexPath.item]
        cell.moviePath = guideMoviePaths[indexPath.item]
        
        return cell
        
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 如果等于最后一个视频 并且播放完成 就回调完成的闭包
        if indexPath.item == guideMoviePaths.count - 1  && isMovieFinished{
            playFinished()
        }
    }
    
}




private extension Selector {
  
    static let finishedPlay = #selector(LCMovieLaunchGuide.finishedPlay)

}

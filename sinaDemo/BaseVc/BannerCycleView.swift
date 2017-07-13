//
//  BannerCycleView.swift
//  sinaDemo
//
//  Created by admin on 17/4/18.
//  Copyright © 2017年 super. All rights reserved.
//  首页的相关 BannerCycleView

import UIKit
private let CycleCellID = "CycleCellID"

protocol BannerCycleViewDelegate {

    func collctionViewClick(collctionView : UICollectionView,indexPath: IndexPath)
    
 
}

class BannerCycleView: UIView {

    var delegate : BannerCycleViewDelegate?
    
    var layout  : UICollectionViewFlowLayout!
    var collectionView :UICollectionView!
    var pageContol : UIPageControl?
    var cycleTimer : Timer?
  
    let timeInterval : TimeInterval = 2
    
    var cycleModels : [CycleModel]? {
        didSet {
            collectionView.reloadData()
            pageContol?.numberOfPages = cycleModels?.count ?? 0
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
            setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension BannerCycleView {
    func  setupUI() {
        
        self.layout = UICollectionViewFlowLayout()
        self.layout.itemSize = CGSize(width: kScreenW, height: 200)
        self.layout.minimumLineSpacing = 0
        self.layout.minimumInteritemSpacing = 0
        self.layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: self.layout)
        
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView .register(CollectionCycleCell.self, forCellWithReuseIdentifier: CycleCellID)
        self.collectionView.backgroundColor = UIColor.white
        self.addSubview(self.collectionView)
        
        self.pageContol = UIPageControl(frame: CGRect(x: self.collectionView.center.x - 50 , y: 130, width: 100, height: 20))
        self.addSubview(self.pageContol!)
        
    }

}


extension BannerCycleView : UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleCellID, for: indexPath) as! CollectionCycleCell
                
//        print(cycleModels![indexPath.item % cycleModels!.count])
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
        
    }

}

extension BannerCycleView : UICollectionViewDelegate {
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      // 计算偏移量
     let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
     
      // 计算页码当前页
        pageContol?.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.collctionViewClick(collctionView: collectionView, indexPath: indexPath)
        
    }
    
    
}


extension BannerCycleView {
  
    fileprivate func addCycleTimer(){
    
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
        
    
    }

    fileprivate func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        collectionView.setContentOffset(CGPoint(x:collectionView.contentOffset.x + collectionView.bounds.width , y:0), animated: true)
        
    }
    

}

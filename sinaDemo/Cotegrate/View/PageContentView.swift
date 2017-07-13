//
//  PageContentView.swift
//  sinaDemo
//
//  Created by admin on 17/4/12.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit


// 定义代理
protocol PageContentViewDelegate {
    func pageContentView(_ contentView : PageContentView ,progress : CGFloat , sourceIndex : Int , targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

     var delegate : PageContentViewDelegate?
    

    let defaultVcCount = UserDefaults.standard.object(forKey: DEFAULT_CHILDVCS) as! Int
    fileprivate var isForbidScrollDelegate : Bool = false
    fileprivate var startOffsetX : CGFloat = 0

    // 存放的是控制器的数组
    fileprivate var childVcs : [UIViewController]

    // 需要改成弱引用，否则有循环引用
    fileprivate weak var parentVc : UIViewController?

    

    
    // 懒加载 collcetionview
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
       let layout = UICollectionViewFlowLayout()
        
        // 使用[weak self] in 后: self.bounds.size => (self?.bounds.size)!
        layout.itemSize = (self?.bounds.size)!
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        

        let  collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ContentCellID")
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
        }()
    
    init(frame: CGRect ,childVcs : [UIViewController],parentVc:UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame:frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


extension PageContentView {
    fileprivate func setupUI(){
    
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
    
        addSubview(collectionView)
        collectionView.frame = bounds
    }


}

extension PageContentView :  UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVcs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ContentCellID , for: indexPath)
        
        for view in cell.contentView.subviews {
          view.removeFromSuperview()
        }
    
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
    
        return cell
    }

}


extension PageContentView : UICollectionViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startOffsetX =  scrollView.contentOffset.x
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {
            return
        }
        // 记录滑动的进度
        var progress : CGFloat = 0
        
        // 第几个的下标
        var sourceIndex : Int = 0
        
        // 滑动到的(控制器)下标
        var targetIndex : Int = 0
        
        // 当前偏移量X
        let currentOffsetX = scrollView.contentOffset.x
        
        // scrollView的宽度
        let scrollViewW = scrollView.bounds.width
        
        // 如果当前的偏移量 大于 起始位置的X 就让它滚到后面一个控制器 否则 就滚到第一个
        if currentOffsetX > startOffsetX {
        
            // 计算滑动的进度位置 < 当前的偏移量X / scrollView的宽度 减去 (当前的偏移量X / scrollView的宽度的绝对值) >
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
           
            // 计算出第几个  强转成Int 是为了更好的设置页数 进行加或减
            sourceIndex = Int(currentOffsetX/scrollViewW)
            
            //当前下标加一 获取到下一个
            targetIndex = sourceIndex+1
            
            // 如果当前下标大于等于控制器的个数 让控制器个数(下标)减一 防止超出个数导致崩溃
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 判断完全滑过去 让进度等于 1 下标和第几个的下标相等
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
            
        
        }else{  // 处在第二页上的时候
            
            // 计算滑动的进度位置
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            
            // 强转成Int 是为了更好的设置页数 进行加或减
            targetIndex = Int(currentOffsetX/scrollViewW)
            
            sourceIndex = targetIndex + 1
            
            // 同上 为了防止超出个数
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
            if startOffsetX - currentOffsetX == scrollViewW {
                sourceIndex = targetIndex
            }

        }
        
        // 代理 - 把外面需要的传出去
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }

}

extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
     
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
        
    }

}


// 外面调用
// MARK: - 公共方法，当添加或移除分类后，需要同步刷新PageContentView
extension PageContentView {
    
    public func reloadChildVcs(newChildVcs: [UIViewController]){

//        print("new-",newChildVcs)
        
        // defaultVcCount
        if self.childVcs.count < defaultVcCount + newChildVcs.count {
            for childVc in newChildVcs{
                self.childVcs.append(childVc)
                parentVc?.addChildViewController(childVc)
            }
        }else{
            let count = self.childVcs.count - (defaultVcCount + newChildVcs.count)
            updateChildVcs(count: count)

        
        }
    
        UserDefaults.standard.set(self.childVcs.count, forKey: HOME_CHILDVCS)
        collectionView.reloadData()
        
    }
    
    // MARK: - 没有添加频道或者移除了所有的频道，回到默认状态
    public func setDefaultChildVcs() {
        
        // 移除 "精彩推荐"和"全部直播"两个频道之外的所有频道控制器
        // 当前子控制器个数 - 默认子控制个数 = 需要移除控制器的个数
        let counts = self.childVcs.count - defaultVcCount
        updateChildVcs(count: counts)
        
        UserDefaults.standard.object(forKey: HOME_CHILDVCS)
        collectionView.reloadData()
        
    }
    
    func updateChildVcs(count:Int) {
        var i = 0
        let lastChildVcsCount = UserDefaults.standard.object(forKey: HOME_CHILDVCS) as! Int
        
        for _ in 0..<count {
            self.childVcs.removeLast()
        }
        
        for childvc in (self.parentVc?.childViewControllers)! {
            if i > (lastChildVcsCount - count - 1) {
                childvc.removeFromParentViewController()
            }
            i += 1
        }
        
        
        for childs in self.childVcs {
            parentVc?.addChildViewController(childs)
        }
        
    }
  
}







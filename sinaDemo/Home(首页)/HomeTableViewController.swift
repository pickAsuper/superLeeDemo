//
//  HomeTableViewController.swift
//  sinaDemo
//
//  Created by admin on 17/4/8.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class HomeTableViewController: UIViewController {

    
    // 懒加载 顶部菜单
    fileprivate lazy var pageMenuView : PageMenuView = {[weak self] in
      
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW , height: kTitleViewH)
        let memuView = PageMenuView(frame:frame)
        memuView.delegate = self
        return memuView
        
    }()
    
    
    // 懒加载控制器
    fileprivate lazy var vc : UIViewController = {
     let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor()
        return vc
    }()
    
    // 中间内容的View 一个View里面承载两个控制器
    fileprivate lazy var pageContentView :PageContentView = {
      
        // 内容的位置大小
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH)
     
        // 装控制器的数组
        var childVcs = [UIViewController]()
        
        let saveCount = UserDefaults.standard.object(forKey: HOME_CHILDVCS) as? Int
        
        if saveCount != nil {
          childVcs.append(RecommendVC())
          childVcs.append(AllLivingVC())
            if saveCount! > 1 {
                for _ in 0..<(saveCount! - 2){
            
                    // 这里需要注意了 .... childVcs.append((self?.vc)!)
                    childVcs.append((self.vc))
                }
             }
            UserDefaults.standard.set(childVcs.count ,forKey: HOME_CHILDVCS)
            
        }else {
            childVcs.append(RecommendVC())
            childVcs.append(AllLivingVC())
            UserDefaults.standard.set(childVcs.count, forKey: DEFAULT_CHILDVCS)
            
        }
        
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        
           contentView.delegate = self
        
        return contentView
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        UIApplication.shared.statusBarStyle = .default
      
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.titleView = UIImageView(image: UIImage(named:"superLee"))

        setupUI()
    }

    
    
    
    
    
}

// MARK - setupUI
extension HomeTableViewController{
    func setupUI() {
      
        view.addSubview(pageMenuView)
        view.addSubview(pageContentView)
        automaticallyAdjustsScrollViewInsets = false
        
    }
    
}

// MARK - PageMenuViewDelegate
extension HomeTableViewController: PageMenuViewDelegate {
  
    func pageMenuView(_ titleView: PageMenuView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
        
    }
}


// MARK - PageContentViewDelegate
extension HomeTableViewController: PageContentViewDelegate {
    
    func pageContentView(_ contentView: PageContentView , progress: CGFloat,sourceIndex: Int, targetIndex: Int){
        
      pageMenuView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }

}



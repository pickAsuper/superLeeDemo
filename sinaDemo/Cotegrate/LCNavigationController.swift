//
//  LCNavigationController.swift
//  sinaDemo
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().setBackgroundImage(UIImage.init(named: "navigationbarBackgroundWhite"),for:UIBarMetrics.default)
        
        self.interactivePopGestureRecognizer?.delegate = nil
        
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
//        print(self.viewControllers.count)

        if self.viewControllers.count < 1 {
            viewController.navigationItem.rightBarButtonItem = setRightButton()
            
        }else{
          viewController.hidesBottomBarWhenPushed = true
          viewController.navigationItem.leftBarButtonItem = setBackBarButtonItem()
        }
      
        // 和OC一样必须调用父类的这句代码
        super.pushViewController(viewController, animated: true)
        
    }
    
    
     // 统一设置导航栏右键按钮
    func setRightButton() -> UIBarButtonItem{
    
        let searchItem = UIButton.init(type: .custom)
        searchItem.setImage(UIImage(named:"timg地图@2x.jpg"), for: UIControlState())
        searchItem.sizeToFit()
        searchItem.frame.size = CGSize(width: 30, height: 30)
        searchItem.contentHorizontalAlignment = .right
        searchItem.addTarget(self, action: #selector(LCNavigationController.mapSearchClick), for:.touchUpInside)
        return UIBarButtonItem.init(customView: searchItem)
    }
    
    
    func mapSearchClick()  {
        
        self.pushViewController(LCSuperMapViewController(), animated: true)
        
        
    }

    // 统一设置导航栏返回按钮
    func setBackBarButtonItem() ->UIBarButtonItem {
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "setting_back"), for: .normal)
        backButton.sizeToFit()
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        backButton.addTarget(self, action: #selector(LCNavigationController.backClick), for: .touchUpInside)
        
        return UIBarButtonItem.init(customView: backButton)
        
        
        
    }
    
    func backClick(){
        self.popViewController(animated: true)
    }
    
}

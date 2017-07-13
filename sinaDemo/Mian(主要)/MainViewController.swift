//
//  MainViewController.swift
//  sinaDemo
//
//  Created by admin on 17/4/8.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController ,LCNewTabBarDelegate{
    
    weak var customTabBar = LCNewTabBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        
        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for child  in self.tabBar.subviews {
            if child.isKind(of: UIControl.self) {
                child.removeFromSuperview()
            }
        }
        
    }
    
    
    fileprivate func addChildViewController(_ childController: UIViewController ,title : String ,imageName : String) {
        
        childController.title = title
        
        childController.tabBarItem.image = UIImage(named: imageName)
        
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let childNav = LCNavigationController(rootViewController: childController)
        
        addChildViewController(childNav)
        
        
        // 设置成自己写的tabbar
        self.customTabBar?.addTabbarButtonWith(childController.tabBarItem)
        
        
    }
    
    
    func setupTabbar() -> Void {
        let customTabBar = LCNewTabBar.init(frame: self.tabBar.bounds)
        customTabBar.tabbarDelegate = self
        self.tabBar.addSubview(customTabBar)
        self.customTabBar = customTabBar
        
    }
    
    
    // tabbar的点击事件
    func tabbar(_ tabbar: LCNewTabBar, formWhichItem: Int, toWhichItem: Int) {
        self.selectedIndex = toWhichItem
    }
    
    
    // 中间按钮的点击事件
    func plusBtnOnClicl() {
    
 
      let mes = QQMessageTableViewController()
      let nav = LCNavigationController.init(rootViewController: mes);
        
     self.present(nav, animated: true, completion: nil)
        
    }
    
    
}



//    fileprivate func setupComposeBtn(){
//        tabBar.addSubview(composeBtn)
//        composeBtn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: UIControlState())
//        composeBtn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), for: .highlighted)
//
//        composeBtn.setImage(UIImage(named:"tabbar_compose_icon_add"), for: UIControlState())
//        composeBtn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), for: .highlighted)
//        composeBtn .sizeToFit()
//        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
//
//    }
//}


//    guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
//        print("没有获取到相对应的文件路径")
//        return
//    }
//
//
//    guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
//        print("没有获取到JSON文件中数据")
//        return
//    }
//
//
//    guard let anyObejct = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
//        return;
//    }
//
//    guard let dictArray =  anyObejct as? [[String :AnyObject]] else {
//        return
//    }
//
//    for dict in dictArray {
//        guard let vcName = dict["vcName"] as? String else {
//            continue
//        }
//        guard let title = dict["title"] as? String else {
//            continue
//        }
//
//        guard let imageName = dict["imageName"] as? String else {
//            continue
//        }
//
//        addChildViewController(vcName, title: title, imageName: imageName)
//
//
//    }
//


//    fileprivate func addChildViewController(_ childVcName: String ,title : String,imageName : String ) {
//
//
//        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
//            print("没有获取到命名空间")
//            return
//        }
//
//        //   1.根据字符串获取对应的Class
//        guard let ChildVcClass = NSClassFromString(nameSpace + "." + childVcName) else {
//            print("没有获取到字符串对应的Class")
//            return
//        }
//
//        // 2.将对应的AnyObject转成控制器的类型
//        guard let childVcType = ChildVcClass as? UIViewController.Type else {
//            print("没有获取对应控制器的类型")
//            return
//        }
//
//        let childVc = childVcType.init()
//
//        childVc.title = title
//        childVc.tabBarItem.image = UIImage(named: imageName)
//        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
//        let childNav = UINavigationController(rootViewController: childVc)
//        addChildViewController(childNav)
//    }

/*
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
 addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
 addChildViewController(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
 addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
 
 }
 
 fileprivate func addChildViewController(_ childController: UIViewController ,title : String ,imageName : String) {
 
 childController.title = title
 childController.tabBarItem.image = UIImage(named: imageName)
 childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
 
 let childNav = UINavigationController(rootViewController: childController)
 
 addChildViewController(childNav)
 
 
 }
 
 
 */

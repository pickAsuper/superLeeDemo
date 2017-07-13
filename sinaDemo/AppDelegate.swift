//
//  AppDelegate.swift
//  sinaDemo
//
//  Created by admin on 17/4/8.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    
    // 百度地图 
    var _mapManager: BMKMapManager?
  
    /*
     * 应用程序第一次运行时执行
     * 这个方法只有在App第一次运行的时候被执行过一次，每次App从后台激活时都不会再执行该方法。
     *（注：所有一般我们都在这里获取用户许可，比如本地消息推送的许可等）
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.orange

        let isLogin = UserDefaults.standard.bool(forKey:"isLogin")
        
        if isLogin {
                window = UIWindow(frame: UIScreen.main.bounds)
                window?.rootViewController = MainViewController()
                window?.makeKeyAndVisible()
        }else{
            setupRootController()
        }
    
        // 设置百度地图
        setupBaiDuMap()
      
        
        return true
    }
    
    
    func setupBaiDuMap(){
       
        _mapManager = BMKMapManager()
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("osrBtsMKw05d6A5GQwLc2Dma5gox4GhK", generalDelegate: self)
       
        if ret == false {
            NSLog("manager start failed!")
        }
        
    
    }

    // 选择根控制器
    func setupRootController() {
        
        // 下面两个都能用
        
//       这个能用 可以打开看看效果
//       var images = [UIImage]()
//       var paths = [String]()
//       
//        for i in 0..<4 {
//            images.append(UIImage(named: "guide\(i)")!)
//            paths.append(Bundle.main.path(forResource: "guide\(i)", ofType: "mp4")!)
//        }
//    
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.backgroundColor = UIColor.white
//        window?.rootViewController = LCMovieLaunchGuide(guideImages: images, guideMoviePaths: paths, playFinished: { 
//            [unowned self] in
//             self.window?.rootViewController = MainViewController()
//            
//            UserDefaults.standard.set(true, forKey: "isLogin")
//            
//        })
//        window?.makeKeyAndVisible()

        // 这是另外一个启动视频
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = LCPulseOnViewController.init(playFinished: {
            [unowned self] in
            self.window?.rootViewController = MainViewController()
             UserDefaults.standard.set(true, forKey: "isLogin")
            
        })
        window?.makeKeyAndVisible()
        
    }
    
    
    
    
   
    /*
     * 应用程序挂起时执行
     * 当有电话进来或者锁屏时，应用程序便会挂起
     */
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // 当应用程序发送即将从活跃不活跃的状态。这可能发生某些类型的暂时中断(如电话来电或短信)或当用户退出应用程序开始转换到背景状态
        
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        // 使用这种方法暂停正在进行的任务,禁用计时器,和无效的图形渲染回调。游戏应该使用这个方法来暂停游戏。
    }

    
    
  
    /*
     * 应用程序进入后台时执行
     */
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // 使用这个方法来释放共享资源,保存用户数据,无效计时器,和储存足够多的应用程序状态信息来恢复您的应用程序的当前状态情况下,终止。
        
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        // 如果您的应用程序支持后台执行,而不是调用此方法applicationWillTerminate:当用户退出
    }

 
    
    
    /*
     * 应用程序将要重新回到前台时执行
     */
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        // 称为过渡的一部分,从背景到活动状态,在这里你可以撤消的许多进入背景所做的更改。
    }

 
    /*
     * 应用程序重新进入活动状态时执行
     */
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        // 重启任何任务暂停(或没有开始),而应用程序是不活跃的。如果应用程序在后台以前,可选更新用户界面
    }

    
    /*
     * 应用程序将要退出时执行
     * 这里通常是用来保存数据和做一些退出前的清理工作
     */
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // 时调用应用程序终止。如果适当的保存数据。看到也applicationDidEnterBackground:
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
      
//        let  traitCollection =  UITraitCollection()
//        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
//            
//            print("你的手机支持3D Touch!")
//            
//        }
//        else {
//            print("你的手机暂不支持3D Touch!")
//            
//        }
        
        switch shortcutItem.type {
        case "cometohome":
           print("你想干啥就在这干吧")
            
//            let activityVC = UIActivityViewController(
//                activityItems: items,
//                applicationActivities: nil)
//            self.window?.rootViewController?.present(activityVC, animated: true, completion: { () -> Void in
//                
//            })
            
        default:
            break
        }
    }
}


extension AppDelegate : BMKGeneralDelegate {

    //MARK: - BMKGeneralDelegate
    func onGetNetworkState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("联网成功");
        }
        else{
            NSLog("联网失败，错误代码：Error\(iError)");
        }
    }
    
    func onGetPermissionState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("授权成功");
        }
        else{
            NSLog("授权失败，错误代码：Error\(iError)");
        }
    }


}

//
//  Common.swift
//  sinaDemo
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 super. All rights reserved.


//   统一配置文件

import UIKit

//归档路径
let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height



let kItemMargin : CGFloat = 10
let kHeaderViewH : CGFloat = 50
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4


let kStatusBarH : CGFloat = 20
let kNavigationBarH : CGFloat = 44
let kTabBarH : CGFloat = 49
let BGCOLOR :UIColor = UIColor(gray:244)


let NormalCellID = "NormalCellID"
let SearchCellID = "SearchCellID"
let HeaderViewID = "HeaderViewID"


let SELECTED_CHANNELS : String = "selectedChannel.archive"
let UNSELECTED_CHANNELS : String = "unselectedChannels.archive"
let PAGE_TITLES:String = "pagetitles.archive"
let HOME_CHILDVCS : String = "childvcs"
let DEFAULT_CHILDVCS: String = "default" // 首页初始化的子控制器
let ALL_GMES: String = "GameVC.archive"


let NotifyUpdateCategory = NSNotification.Name(rawValue: "notifyUpdateCategory")
let KSelectedChannel: String = "selectedChannel"



let common = Common()


class Common: NSObject {

    
    class func itemWithImage(_ image:UIImage , highlightImage:UIImage,target:UIViewController,action:Selector) ->UIBarButtonItem {
        let button = UIButton.init()
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(highlightImage, for: .highlighted)
        
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        
        return UIBarButtonItem.init(customView:  button)
    }

   //   归档 保存的是GameModel数组
    func archiveData(channel:[GameModel] , appendPath : String) {
        
        let filePath = path.appendingPathComponent(appendPath)
        NSKeyedArchiver.archiveRootObject(channel, toFile: filePath)
        
    }
    
    
    // 解档
    func unarchiveData(appendPath:String) -> ([GameModel]?) {
        let filePath = path.appendingPathComponent(appendPath)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [GameModel]
        
    }
    
    
    // 归档 保存的是String数组
    func archiveWithStringArray(channel: [String] , appendPath:String) {
        let filePath = path.appendingPathComponent(appendPath)
        NSKeyedArchiver.archiveRootObject(channel, toFile: filePath)
        
        
    }
    
    // 解档
    func unarchiveToStringArray(appendPath: String) -> ([String]?) {
        let filePath = path.appendingPathComponent(appendPath)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [String]
        
        
    }
    
    // 归档 数组里面放的任意的值
    func archive(array : [AnyObject] , appendPath : String){
       let filePath = path.appendingPathComponent(appendPath)
       NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
    }
    
    func unarchive(appendPath : String) -> ([AnyObject]?) {
        let filePath = path.appendingPathComponent(appendPath)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! ([AnyObject]?)
        
    }
    
    
    
    
    
}


// 发现界面的东西
let BASE_URL = "http://open3.bantangapp.com/"

///滚播图的  url
let SCROLL_IMG = "recommend/index?"

///搜索界面的 url
let SAERCH_URL = "post/index/index?"

let SEARCH_LIST = "post/index/listByNew?"


let headSegmentArray = ["推荐","最新","热门","礼物","美食","生活","设计感","家居","数码","阅读","学生党","上班族","美妆","护理","运动户外","健康"]







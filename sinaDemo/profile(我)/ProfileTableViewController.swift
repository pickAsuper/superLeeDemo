//
//  ProfileTableViewController.swift
//  sinaDemo
//
//  Created by admin on 17/4/8.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

private let kProfileCellID = "kProfileCellID"
//private let kHeaderViewH: CGFloat = 252
private let kFreeTraficURL = "http://www.cnblogs.com/supersr"
private let kMeSubScribe   = "我的订阅"
private let kMePlayHistory = "播放历史"
private let kMeHasBuy      = "我的已购"
private let kMeWallet      = "我的钱包"
private let kMeStore       = "直播商城"
private let kMeStoreOrder  = "我的商城订单"
private let kMeCoupon      = "我的优惠券"
private let kMeGameenter   = "游戏中心"
private let kMeSmartDevice = "智能硬件设备"
private let kMeFreeTrafic  = "免流量服务"
private let kMeFeedBack    = "意见反馈"
private let kEditMyInfo    = "编辑资料"
private let kMeSetting     = "设置"


class ProfileTableViewController: UIViewController{

    // 登录按钮
    lazy var rightBarButton : UIButton = {
        let rightBarButton = UIButton()
            rightBarButton.setTitle("登录", for: .normal)
            rightBarButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            rightBarButton.setTitleColor(UIColor.white, for: .normal)
            rightBarButton.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
            return rightBarButton
        
    }()

    // 头像
    lazy var avatarView :UIImageView = {
        let avatarView = UIImageView()
            avatarView.frame = CGRect(x: 100, y: 100, width: 80, height: 80)
            avatarView.layer.cornerRadius = avatarView.bounds.height/2
            avatarView.layer.masksToBounds = true
            avatarView.layer.borderColor = UIColor.white.cgColor
            avatarView.layer.borderWidth = 3
            avatarView.backgroundColor = UIColor.orange
            avatarView.image = UIImage(named: "头像@2x.jpg");
            return avatarView
    }()

    // 水波View
    lazy var waterView : LCWaveView = {
        let waterView = LCWaveView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 200), color: UIColor.white)
            waterView.addOverView(oView: self.avatarView)
            waterView.backgroundColor = UIColor.orange
        
        
            waterView.waveHeight = 10
        
            waterView.startWave()
            return waterView
    
    }()
    
    
    var lightFlag : Bool = true
    fileprivate lazy var titleArr:[String] = {
        return [kMeSubScribe, kMePlayHistory,kMeHasBuy, kMeWallet,kMeStore, kMeStoreOrder, kMeCoupon, kMeGameenter, kMeSmartDevice,kMeFreeTrafic, kMeFeedBack, kEditMyInfo, kMeSetting]

    }()
    
    lazy var imageArray:[String] = {
        return ["mine_follow", "mine_money","mine_fanbao", "mine_bag","mine_money", "mine_money", "mine_bag", "mine_fanbao", "mine_follow","mine_fanbao", "mine_bag", "mine_edit","mine_set"]

    }()
    

    
    lazy var urlArray:[String] = {
        return [
            "http://www.7xdy.cn", "http://m.fzdnl.cn","http://www.gxdy2.cn",
            "http://m.fzcry.cn","http://uu.sxzxmp.com/list/?1.html=", "http://www.cswanda.com/movie/play.html?06021=",
            "http://021.wx1080.com", "http://v.qq.comm.qbltq.cn/app/index.php?i=2&c=entry&do=index&m=iweite_vipvods", "http://m.xh800.cn/index.html",
            "http://www.87evd.com", "http://www.1gmm.com", "http://www.27kdy.com",kFreeTraficURL]
        
    }()
    
    lazy var tableView :UITableView = {
        
       let frame = CGRect(x: 0, y: 200, width: kScreenW, height: kScreenH - 200 - 64);
       let tableView = UITableView(frame:frame , style: .plain)
          tableView.delegate = self
          tableView.dataSource = self
          tableView.register(UITableViewCell.self, forCellReuseIdentifier: kProfileCellID)
          tableView.showsVerticalScrollIndicator = false
          return tableView
  
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        // 统一设置导航栏的改变
        navSetUpChange()

        // 设置导航栏的线 和 文字
        navSetUpLineAndTitle()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
          return .lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
        view.addSubview(waterView)
        
        view.addSubview(tableView)
    }

    
    
}

extension ProfileTableViewController{
 
    func rightBarButtonItemClick() {
        navigationController?.pushViewController(LCLoginViewController(), animated: true)
        navSetUpChange()
    }
    
    func navSetUpChange() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    // 设置导航栏的线 和 文字
    func navSetUpLineAndTitle(){
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        
    }


}


extension ProfileTableViewController : UITableViewDelegate , UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let subTitleArr = titleArr[indexPath.section]
//        let subImageArr = imageArray[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: kProfileCellID, for: indexPath)
        cell.textLabel?.text = titleArr[indexPath.row]
        cell.imageView?.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
        
        let webViewVc  = LCWebPageViewController()
       
            webViewVc.urlString = urlArray[indexPath.row]
    
        self.navigationController?.pushViewController(webViewVc, animated: true)

    }
}



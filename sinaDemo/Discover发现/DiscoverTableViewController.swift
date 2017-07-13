//
//  DiscoverTableViewController.swift
//  sinaDemo
//
//  Created by admin on 17/4/8.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON

private let listCell = "listCell"

class DiscoverTableViewController: UIViewController {

    // //
    
    // 登录按钮
    lazy var rightBarButton : UIButton = {
        let rightBarButton = UIButton()
//        rightBarButton.setTitle("登录", for: .normal)
        rightBarButton.setImage(UIImage(named:"searchbutton_nor"), for: .normal)
        rightBarButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rightBarButton.setTitleColor(UIColor.white, for: .normal)
        rightBarButton.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        return rightBarButton
        
    }()

    
    fileprivate lazy var loadView: UIView = { [unowned self] in
        let view = UIView()
            view.frame = CGRect(origin: .zero, size: CGSize(width: kScreenW, height: kScreenH - kNavigationBarH))
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            let imageView = UIImageView(image: UIImage(named: "0tai_icon2-1"))
            imageView.center = view.center
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            let title = UILabel()
            title.font = UIFont.systemFont(ofSize: 13)
            title.textColor = UIColor.darkGray
            title.text = "在这里，你会找到最有趣的生活。"
            title.textAlignment = .center
            title.center = CGPoint(x: imageView.center.x, y: imageView.frame.maxY+10)
            title.bounds.size = CGSize(width: kScreenW, height: 20)
            
            view.addSubview(imageView)
            view.addSubview(title)
            return view
        
        }()
        
    var listArray = Array<ListModel>()
    
    
    // 顶部的 HeadeView
    lazy var headView : SearchHeadView = {
      let headview = SearchHeadView.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 0))

        return headview
    }()
    
    // tableView 懒加载
    lazy var tableView : UITableView = {
       
      let table = UITableView.init(frame:  CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH), style: .plain)
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    
    // 搜索框
    lazy var searchBar : UISearchBar = {
        let search : UISearchBar = UISearchBar(frame: CGRect(x: -(kScreenW - 60), y: 30, width: kScreenH - 80, height: 30))
        search.placeholder = "搜索值得买的好物"
        search.layer.cornerRadius = 15
        search.layer.masksToBounds = true
        
        search.setSearchFieldBackgroundImage(UIImage.image(color: UIColor.lightGray.withAlphaComponent(0.4), size: search.frame.size), for: .normal)
        search.setBackgroundImage(UIImage.image(color: UIColor.lightGray.withAlphaComponent(0.4), size: search.frame.size), for: UIBarPosition.any, barMetrics: .default)
        
        
        let tf = search.value(forKey: "_searchField") as! UITextField
        tf.textColor  = UIColor.white
        tf.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")

        return search
        
    }()
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UIApplication.shared.statusBarStyle = .default

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.navigationItem.titleView = self.searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
        loadData()
        loadList()
        
        self.view.addSubview(self.tableView)

//        view.addSubview(loadView)

    }

    
    
    func rightBarButtonItemClick(){
    
        let searchVc = LCSearchViewController()
        self.navigationController?.pushViewController(searchVc, animated: true)

        
    }
    
    
    func loadData(){
     
        let para = ["app_id":"com.jzyd.BanTang",
                    "app_installtime":"1482905598",
                    "app_versions":"5.9.5",
                    "channel_name":"appStore",
                    "client_id":"bt_app_ios",
                    "client_secret":"9c1e6634ce1c5098e056628cd66a17a5",
                    "oauth_token":"4150e754a624ecdc255ad1d13f6287bc",
                    //"last_get_time":"1463238932",
            "os_versions":"10.2",
            "screensize":"750",
            "track_device_info":"iPhone8,4",
            "track_device_uuid":"DE964894-8C6F-48BF-9F6C-A47167353EAC",
            "track_deviceid":"BAEA9AD2-16E3-4D12-8E28-4EB9F15A1412",
            "track_user_id":"2777434",
            "v":"24"
            //"page":"0",
            //"pagesize":"20"
        ]

        NetRequest.shareInstance.getRequest(urlString: BASE_URL.appending(SAERCH_URL), params: para) { (response, error) in
         
            if response == nil{
               return
            }
            
            let json = JSON(response!)
            
            let model = DiscoverSearchModel.init(dic: json["data"])

            
            var height = CGFloat()
            
            let count = model.activity_list.count%2
            if count == 0  {
            
                height = CGFloat(model.activity_list.count/2*80)
                
            }else{
            
                height = CGFloat(model.activity_list.count/2 + 1)

            }
            
            self.headView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height+240)
            self.tableView.tableHeaderView = self.headView
            self.headView.sendModel(model: model)
            self.tableView.reloadData()
            
        }
    
        
        
    
    }
  
    func loadList(){
        
        let para = ["app_id":"com.jzyd.BanTang",
                    "app_installtime":"1482905598",
                    "app_versions":"5.9.5",
                    "channel_name":"appStore",
                    "client_id":"bt_app_ios",
                    "client_secret":"9c1e6634ce1c5098e056628cd66a17a5",
                    "oauth_token":"4150e754a624ecdc255ad1d13f6287bc",
                    "os_versions":"10.2",
                    "screensize":"750",
                    "track_device_info":"iPhone8,4",
                    "track_device_uuid":"DE964894-8C6F-48BF-9F6C-A47167353EAC",
                    "track_deviceid":"BAEA9AD2-16E3-4D12-8E28-4EB9F15A1412",
                    "track_user_id":"2777434",
                    "v":"24",
                    "page":"0",
                    "pagesize":"20"
        ]
        
        
        NetRequest.shareInstance.getRequest(urlString: BASE_URL.appending(SEARCH_LIST), params: para) { (response, error) in
           
            if response == nil{
                return
            }
            
            let json = JSON(response!)
            for(_,subJosn):(String,JSON) in json["data"]["list"] {
                let model = ListModel.init(dic: subJosn)
                self.listArray.append(model)
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }

    
}



extension DiscoverTableViewController :UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: listCell) as? ListCell
        if cell == nil {
            cell = ListCell(style: .default, reuseIdentifier: listCell)
        }
       
        
        cell?.sendModel(model: self.listArray[indexPath.row])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_ :)))
         cell?.bigImg.addGestureRecognizer(tap)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SearchSegmentView.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 30))
        
        view.backgroundColor = UIColor.white
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.listArray[indexPath.row]
        if model.post.middle_pic_url.isEmpty == true {
            return 350
        }else{
            return 480
        }
}

    
}

extension DiscoverTableViewController : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }

}

extension DiscoverTableViewController {

    func tapGesture(_ tap:UITapGestureRecognizer){
        let imageView:UIImageView = tap.view?.viewWithTag(100) as! UIImageView
        
        let bigPicVC =  LCBigPictureViewController()
            bigPicVC.picture = imageView.image!
       
        self.present(bigPicVC, animated: false, completion: nil)
    }

}

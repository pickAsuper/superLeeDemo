//
//  MessageTableViewController.swift
//  sinaDemo
//
//  Created by admin on 17/4/8.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageTableViewController: UIViewController {

    
    var listArray = Array<OnLinePlayerConentModel>()
    
    // tableView 懒加载
    lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame:  CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        // fj03@2x.jpg
//        tableView.backgroundView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
        tableView.backgroundView = UIImageView(image: UIImage(named: "fj03@2x.jpg"))

        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
        UIApplication.shared.statusBarStyle = .lightContent

        
    }
    
   

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UIApplication.shared.statusBarStyle = .lightContent
        
        setupUI()
        loadList()
    }

    
    
    func setupUI()  {
//          设置导航栏的背景颜色
//        self.navigationController?.navigationBar.barTintColor = UIColor.orange
     
        self.title = "列表"
        
        //  设置导航栏标题的字体颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
    
        
        // 去掉🔍
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: UIView())

        self.view.backgroundColor = UIColor.white

       
       
        self.view.addSubview(tableView)
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
    
    
    
    func loadList(){

        NetRequest.shareInstance.getRequest(urlString: "http://fm.baidu.com/dev/api/?tn=channellist&hashcode=310d03041bffd10803bc3ee8913e2726&_=1428801468750", params: nil) { (response, error) in
          
            if response == nil{
                return
            }
            
            let json = JSON(response!)
            for(_,subJosn):(String,JSON) in json["channel_list"]{
              
                let model = OnLinePlayerConentModel.init(dict: subJosn)

                self.listArray.append(model)
                
                self.tableView.reloadData()
                
            }
        }
    }
}

extension MessageTableViewController : UITableViewDelegate,UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "as")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "as")
        }
       let model = self.listArray[indexPath.row]
        
        cell?.textLabel?.textColor = UIColor.orange
        cell?.detailTextLabel?.textColor = UIColor.orange
      
        cell?.imageView?.image = UIImage(named:"xinjiangedan_pressed")
        cell?.textLabel?.text = model.channel_name
        cell?.detailTextLabel?.text = model.cate
        
        cell?.backgroundColor = UIColor.clear
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .none
        
        return cell!
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        let DetailVC = LCOnLinePlayerDetailController()
        
        DetailVC.detailModel = self.listArray[indexPath.row]
        
        self.navigationController?.pushViewController(DetailVC, animated: false)
        

    }


}




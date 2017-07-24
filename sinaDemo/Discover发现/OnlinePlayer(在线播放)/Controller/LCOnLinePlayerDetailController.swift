//
//  LCOnLinePlayerDetailController.swift
//  sinaDemo
//
//  Created by admin on 2017/5/19.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON


class LCOnLinePlayerDetailController: UIViewController {

   lazy var detailModel = OnLinePlayerConentModel(dict: "")
    
    var listArray = Array<OnLinePlayerDetailModel>()

    
    // tableView 懒加载
    lazy var tableView : UITableView = {
        
        let tableView = UITableView.init(frame:  CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH), style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
            tableView.backgroundView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
//            tableView.separatorStyle = .none
            self.view.addSubview(tableView)
  
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
        
              
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "歌曲"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.rgba(red: 84, green: 70, blue: 58, alpha: 1)
        
        loadDetailList()
        
    }

    
    func loadDetailList()   {
        var  strUrl  = "http://fm.baidu.com/dev/api/?tn=playlist&hashcode=310d03041bffd10803bc3ee8913e2726&_=1428917601565&id=\(self.detailModel.channel_name)"

     
        strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet(charactersIn:"`#%^{}\"[]|\\<> ").inverted)!
        

        NetRequest.shareInstance.getRequest(urlString: strUrl) { (response, error) in
           
            if response == nil{
                return
            }
            
            let json = JSON(response!)
            
//            print(json)
            
            var strM = NSString(stringLiteral: "")
            var parasStr = String()
            for(_,subJosn):(String,JSON) in json["list"]{

                let model = OnlineListModel.init(dict: subJosn)
                
                 strM = strM.appendingFormat("%zd,", model.id)
                
                 parasStr =  strM.substring(to: strM.length - 1)
                
            }

            let params = ["songIds":parasStr]
            
             NetRequest.shareInstance.postRequest(urlString: "http://fm.baidu.com/data/music/songinfo", params: params, finished: { (response, error) in
              
                if response == nil{
                    return
                }

                
                let json = JSON(response!)

                
                for(_,subJosn):(String,JSON) in json["data"]["songList"] {
                    let model = OnLinePlayerDetailModel.init(dict: subJosn)
                    
//                    print(model.albumName)
                    
                    self.listArray.append(model)
                    
                }
                
                self.tableView.reloadData()

                
            })
            
            
        }
        
    }
   
}


extension LCOnLinePlayerDetailController:UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LCOnLinePlayerListCellID") as? LCOnLinePlayerListCell
        
        if cell == nil {
            cell = LCOnLinePlayerListCell(style: .default, reuseIdentifier: "LCOnLinePlayerListCellID")
        }
        cell?.selectionStyle = .none

        cell?.backgroundColor = UIColor.clear
       
        cell?.sendModel(model: self.listArray[indexPath.row])
        
        return cell!
    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        QQMusicOperationTool.shareInstance.pauseCurrentMusic()
//        middleView.foreImageView.layer.pauseAnimate()
        
        let interfaceVC = LCOnLinePlayerInterfaceController()
        interfaceVC.listModel = self.listArray[indexPath.row]
        self.navigationController?.pushViewController(interfaceVC, animated: true)
        
        
    }


}

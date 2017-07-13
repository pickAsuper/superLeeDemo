//
//  QQMessageTableViewController.swift
//  sinaDemo
//
//  Created by admin on 2017/5/17.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

//class QQMessageTableViewController: UITableViewController {
class QQMessageTableViewController: UIViewController{

    // 触摸点和中心点x方向移动的距离
    var xDistance:CGFloat?
    
    //  触摸点和中心点y方向移动的距离
    var yDistance:CGFloat?
    
     var netTranslation : CGPoint!//平移
    
    // 是否触摸
    var isDrag:Bool?
    
    lazy var tableView : UITableView = {
      let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    lazy var closeBtn : UIButton = {
        let closeBtn = UIButton()
        
//            closeBtn.setTitle("关闭", for: .normal)
       
          self.xDistance = kScreenW - 50
        
          closeBtn.frame = CGRect(x: kScreenW - 100, y: kScreenH - 100, width: 80, height: 60)
        
          closeBtn.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
          closeBtn.setBackgroundImage(UIImage(named:"guanbi@2x.jpg"), for: .normal)
          closeBtn.addTarget(self, action: #selector(closeBtnClick(_ :)), for: .touchUpInside)
    
       

        let pan =  UIPanGestureRecognizer(target: self, action: #selector(closeBtnMove(_ :)))
        
        closeBtn.addGestureRecognizer(pan)
             return closeBtn
        }()
    
        var musicMs:[QQMusicModel] = [QQMusicModel](){
            didSet{
                tableView.reloadData()
            }
            
        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        
            UIApplication.shared.statusBarStyle = .lightContent

        
        }
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
        
            
            netTranslation = CGPoint(x: 0, y: 0)
            setupUI()
            QQMusicDataTool.getMusicMs { (models:[QQMusicModel]) in
                self.musicMs = models
                QQMusicOperationTool.shareInstance.musicMs = models
            }
        }
        
        
        
        func setupUI()  {
            tableView.backgroundView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
            tableView.separatorStyle = .none
            navigationController?.isNavigationBarHidden = true
            tableView.isUserInteractionEnabled = true
            
            view.addSubview(tableView)
            
            view.insertSubview(closeBtn, aboveSubview: tableView)
    
         }
    
        func closeBtnMove(_ pan:UIPanGestureRecognizer){
          
            if pan.state == .changed {
             // 这里取得的参照坐标系是该对象的上层View的坐标
             let offset = pan.translation(in: self.view)
                
             var x = closeBtn.center.x + offset.x
             var y = closeBtn.center.y + offset.y
               
            if x > self.view.right -  closeBtn.width / 2 {
                x = self.view.right - closeBtn.width / 2
            }else if x < self.view.left + closeBtn.width / 2 {
                x = self.view.left + closeBtn.width / 2
            }
               
            if y < self.view.top + closeBtn.height / 2 + 20 {
                y = self.view.top + closeBtn.height / 2 + 20
            }else if y > self.view.bottom - closeBtn.height / 2 - 10  {
               y = self.view.bottom - closeBtn.height / 2 - 10
            }
               
            closeBtn.center = CGPoint(x: x, y: y)
                
            // 初始化sender中的坐标位置 如果不初始化，移动坐标会一直积累起来
            pan.setTranslation(CGPoint(x:0,y:0), in: self.view)
                
            }else if pan.state == .ended{
                if closeBtn.center.x >= self.view.center.x {
                    UIView.animate(withDuration: 0.5, animations: { 
                        self.closeBtn.right = self.view.right
                    })
                }
            
            }else{
                UIView.animate(withDuration: 0.5, animations: {
                    self.closeBtn.left = self.view.left
                })
            
            
            }
            
        }
    
    
        func closeBtnClick(_ sender: UIButton) {
        
           self.dismiss(animated: true, completion: nil)
        
        }

    

    
    
        override var preferredStatusBarStyle: UIStatusBarStyle{
            get{
                return .lightContent
            }
        }
        
        
    
}


extension QQMessageTableViewController : UITableViewDelegate,UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return musicMs.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "musicCellID"
        let cell = QQMusicCell(style: .default, reuseIdentifier: cellID)
        
        cell.musicM = musicMs[indexPath.row]
        
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        QQMusicOperationTool.shareInstance.playMusic(musicMs[(indexPath as NSIndexPath).row])
        self.navigationController?.pushViewController(QQDetailVC(), animated: true)
    }

}

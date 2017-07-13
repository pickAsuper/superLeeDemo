//
//  LCBigPictureViewController.swift
//  sinaDemo
//
//  Created by admin on 2017/5/18.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import Kingfisher

class LCBigPictureViewController: UIViewController {

    
    lazy var bigImageArray = [String]()
    
    // 里面装 网络图片地址
    lazy var urlImageArray = [String]()

    
    var bigImageView = UIImageView()
    
    
    var picture = UIImage()
    
    fileprivate lazy var scorllView: UIScrollView = {
        let scorllView = UIScrollView(frame: self.view.bounds)
            scorllView.backgroundColor = UIColor.black
            scorllView.isPagingEnabled = true
            scorllView.showsHorizontalScrollIndicator = false
            return scorllView
    }()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        self.urlImageArray.removeAll()
        bigImageArray.removeAll()
        bigImageView .removeFromSuperview()
        scorllView.removeFromSuperview()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(scorllView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_ :)))
        scorllView.addGestureRecognizer(tap)
       

        if bigImageArray.count != 0 {
            
        for i in 0..<bigImageArray.count {
            bigImageView = UIImageView(frame: CGRect(x:CGFloat(i) * kScreenW , y: 0, width: kScreenW, height: kScreenH))
            bigImageView.image = UIImage(named: bigImageArray[i])
            bigImageView.isUserInteractionEnabled = true

            let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_ :)))
            bigImageView.addGestureRecognizer(tap)

            scorllView.addSubview(bigImageView)
            scorllView.contentSize = CGSize(width: CGFloat(i + 1) * kScreenW, height: 0)
            
         }
        }else if urlImageArray.count != 0{
            for i in 0..<urlImageArray.count {
                bigImageView = UIImageView(frame: CGRect(x:CGFloat(i) * kScreenW , y: 0, width: kScreenW, height: kScreenH))
                
                let iconURL = URL(string: urlImageArray[i])
                bigImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "timzwt@2x.jpg"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
                
                bigImageView.isUserInteractionEnabled = true
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_ :)))
                bigImageView.addGestureRecognizer(tap)
                
                scorllView.addSubview(bigImageView)
                scorllView.contentSize = CGSize(width: CGFloat(i + 1) * kScreenW, height: 0)
                
            }
        
        }else{ // 一张图片的
            
//            bigImageView = UIImageView(frame: CGRect(x:0 , y: 0, width: kScreenW, height: picture.size.height))
            
            bigImageView.image = picture

            bigImageView.contentMode = .scaleAspectFit
            
            bigImageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_ :)))
            bigImageView.addGestureRecognizer(tap)
            
            scorllView.addSubview(bigImageView)
            scorllView.contentSize = CGSize(width:kScreenW, height: 0)

            
            bigImageView.snp.makeConstraints({ (make) in
                make.center.equalTo(scorllView.center)
                make.width.equalTo(picture.size.width)
                make.height.equalTo(picture.size.height)
            })
        
        }
        
        
        
    }

    deinit {
        urlImageArray.removeAll()
        bigImageArray.removeAll()
        bigImageView .removeFromSuperview()
        scorllView.removeFromSuperview()
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.dismiss(animated: false, completion: nil)
    }

}

extension LCBigPictureViewController {
    
    func tapGesture(_ tap:UITapGestureRecognizer){
       
        self.dismiss(animated: false) {
            self.urlImageArray.removeAll()
            self.bigImageArray.removeAll()
            self.bigImageView .removeFromSuperview()
            self.scorllView.removeFromSuperview()
        }
        
    }

}

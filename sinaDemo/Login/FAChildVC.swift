//
//  FAChildVC.swift
//  sinaDemo
//
//  Created by admin on 17/4/20.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class FAChildVC: UIViewController {

    // view 的懒加载
    lazy var childOneView : LCChildOneView = {
     let childView = LCChildOneView()
         childView.frame = CGRect(x: 0, y: 0, width: kScreenW + kScreenW, height: kScreenH)

         return childView
    
    }()
    
    lazy var childTwoView : LCChildTwoView = {
        let childTwoView = LCChildTwoView()
        childTwoView.frame = CGRect(x: kScreenW, y: 0, width: kScreenW, height: kScreenH)
//        childTwoView.backgroundColor = UIColor.yellow
        return childTwoView
        
    }()

    lazy var childThreeView : LCChildTwoView = {
        let childThreeView = LCChildTwoView()
        childThreeView.topImageView.image = UIImage(named: "stopwatch")
        childThreeView.textStringLabel.text = "Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time"
        childThreeView.frame = CGRect(x:kScreenW * 2, y: 0, width: kScreenW, height: kScreenH)
//        childThreeView.backgroundColor = UIColor.green
        return childThreeView
        
    }()
    
    lazy var childFourView : LCChildTwoView = {
        let childFourView = LCChildTwoView()
            childFourView.topImageView.image = UIImage(named: "mortarboard")
            childFourView.textStringLabel.text = "Talent is always conscious of its own abundance, and does not object to sharing. Please share your knowledge with others. It will help them and you as well"
            childFourView.frame = CGRect(x: kScreenW * 3, y: 0, width: kScreenW, height: kScreenH)
//        childFourView.backgroundColor = UIColor.purple
        return childFourView
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.addSubview(childOneView)
        
        self.view.addSubview(childTwoView)
        
        self.view.addSubview(childThreeView)
        
        self.view.addSubview(childFourView)
      

    
    }

  

   
}

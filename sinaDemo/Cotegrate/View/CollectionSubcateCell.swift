//
//  CollectionSubcateCell.swift
//  sinaDemo
//
//  Created by admin on 17/4/11.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class CollectionSubcateCell: UICollectionViewCell {

    
    fileprivate lazy var itemButton : UIButton = {
        let itemButton = UIButton()
        itemButton.backgroundColor = UIColor.white
        itemButton.layer.borderColor = UIColor.orange.cgColor
        itemButton.layer.borderWidth = 0.5
        itemButton.setTitle("英雄联盟", for: .normal)
        itemButton.setTitleColor(UIColor.orange, for: .normal)
        itemButton.frame = self.contentView.frame
        itemButton.isUserInteractionEnabled = false
//        itemButton.addTarget(self, action: #selector(itemButtonClick), for: .touchUpInside)
        return itemButton
    
    }()
  
    fileprivate lazy var label : UILabel = {
       let label = UILabel()
        label.frame = self.contentView.frame
        label.backgroundColor = UIColor.purple
        label.text = "hhhhh哈哈"
        return label
    }()
    
    fileprivate lazy var view : UIView = {
      let view = UIView()
        view.backgroundColor = UIColor.yellow
        view.frame = self.contentView.frame
        
    return view
        
    }()
   
    override init(frame: CGRect) {
       super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupUI() {
        
        self.contentView.addSubview(itemButton)
//    view.addSubview(label)
//    self.contentView.addSubview(view)
    
    }
    
    
    var subcateModel :GameModel? {
    
        didSet{
            itemButton.setTitle(subcateModel?.cname, for: .normal)
        }
    
    }
    
    
//    func itemButtonClick(){
//      print("哈哈哈哈哈")
//    }
    
}

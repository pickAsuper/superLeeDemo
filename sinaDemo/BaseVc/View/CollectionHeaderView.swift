//
//  CollectionHeaderView.swift
//  sinaDemo
//
//  Created by admin on 17/4/19.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import Kingfisher


protocol CollectionHeaderViewDelegate : class {
    func moreLivingList(cataName: String , titleName : String )
}

class CollectionHeaderView: UICollectionReusableView {
    
    
    weak var delegate: CollectionHeaderViewDelegate?
    
    
    lazy var bottomView :UIView = {
      let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        bottomView.frame = CGRect(x: 0, y: 10, width: kScreenW, height: 40)
        return bottomView
    }()
    
    lazy var bgView :UIView = {
      let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 50)
        bgView.backgroundColor = UIColor.init(r: 234, g: 234, b: 234)
        return bgView
    }()
    
    lazy var iconImageView :UIImageView = {
     let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "defult_h_icon_13x13_")
        iconImageView.sizeToFit()
        iconImageView.center.y = 20
        iconImageView.frame.origin.x = 10
        return iconImageView
    }()
    
    lazy var titleLabel : UILabel = {
      let titleLabel = UILabel()
        titleLabel.text = "哈哈哈"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.frame = CGRect(x: self.iconImageView.frame.size.width + 15, y: 0, width: 200, height: 40)
//        titleLabel.backgroundColor = UIColor.yellow
        return titleLabel
    }()
    

    
    lazy var lcArrowBtn : LCArrowBtn = {
        let lcArrowBtn = LCArrowBtn()
        lcArrowBtn.setTitle("更多", for: .normal)
        lcArrowBtn.setTitleColor(UIColor.lightGray, for: .normal)
        lcArrowBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        lcArrowBtn.setImage(UIImage(named:"home_more_13x13_"), for: .normal)
        lcArrowBtn.frame = CGRect(x: self.bottomView.frame.width - 60, y: 0, width: 60, height: 40)
        lcArrowBtn.addTarget(self, action: #selector(arrowBtnClick(_ :)), for: .touchUpInside)
        
//        lcArrowBtn.backgroundColor = UIColor.green
        return lcArrowBtn
        
    }()
    
    var total : Int? {
        didSet{
            if total! <= 4 {
                lcArrowBtn.isHidden  = true
            }else{
               lcArrowBtn.isHidden = false
            }
        }
    }
    
    var group : TypeModel? {
        didSet{
           titleLabel.text = group?.value(forKeyPath: "cname") as! String?
            
            guard let url = URL(string: ((group?.value(forKeyPath: "icon") as! String))) else { return }
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "defult_h_icon_13x13_"))

            
        }
    
    }
    
    
    func arrowBtnClick(_ sender : LCArrowBtn ){
    let s1 = group?.value(forKeyPath: "ename") as! String
    let s2 = titleLabel.text
    delegate?.moreLivingList(cataName: s1, titleName: s2!)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CollectionHeaderView
{
    func setupUI() {
    
    self.addSubview(bgView)
    bottomView.addSubview(iconImageView)
    bottomView.addSubview(titleLabel)
    bottomView.addSubview(lcArrowBtn)
    bgView.addSubview(bottomView)
        
        
    }

}

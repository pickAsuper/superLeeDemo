//
//  ListCell.swift
//  sinaDemo
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    // 初始化控件
    var img = UIImageView()
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var bigImg    = UIImageView()
    var relationButton = UIButton()
    var contentLabel = UILabel()
    var shareView = ShareBottomView()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        // 头像
        img = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        
//        img.backgroundColor = UIColor.red
        
        self.contentView.addSubview(img)
        
        // 昵称
        nameLabel = UILabel(frame: CGRect(x: img.right+10, y: img.top, width: 0, height: 20))
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(nameLabel)
    
        // 时间
        dateLabel = UILabel(frame: CGRect(x: img.right+10, y: nameLabel.bottom+5, width: 0, height: 10))
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        dateLabel.textColor = UIColor.lightGray
        self.contentView.addSubview(dateLabel)
    
        
        // 大图
        bigImg = UIImageView(frame: CGRect(x: 15, y: img.bottom+20, width: kScreenW - 15 * 2, height: kScreenW-15*2 - 50))
        bigImg.isUserInteractionEnabled = true
        bigImg.image =  UIImage(named: "头像@2x.jpg")
        bigImg.tag = 100
        self.contentView.addSubview(bigImg)
        
        
        relationButton = UIButton(type: .custom)
        relationButton.setTitleColor(UIColor.red, for: .normal)
        relationButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.contentView.addSubview(relationButton)
        
        contentLabel = UILabel(frame: CGRect(x: relationButton.right, y: relationButton.top, width: 0, height: 10))
        
        contentLabel.font = UIFont.systemFont(ofSize: 10)
        contentLabel.numberOfLines = 0
        self.contentView.addSubview(contentLabel)
        
        let attentionBtn = UIButton(frame: CGRect(x: kScreenW-65, y: 15, width: 50, height: 20))
        attentionBtn.setTitle("+关注", for: .normal)
        attentionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        attentionBtn.setTitleColor(UIColor.white, for: .normal)
        attentionBtn.layer.cornerRadius = 2
        attentionBtn.layer.masksToBounds = true
        attentionBtn.backgroundColor = UIColor.rgba(red: 255, green: 95, blue: 102, alpha: 1)
        self.contentView.addSubview(attentionBtn)
        
        // 底部分享的View
        shareView = ShareBottomView(frame: CGRect(x: 0, y: 0, width: kScreenW , height: 50))
        self.contentView.addSubview(shareView)
        
    }
    
    
    // 设置数据
    func sendModel(model:ListModel) {
//        print(model.post.user.avatar)
//        print(model.topic.user.avatar)
        
//        self.img.image = UIImage(named: "头像@2x.jpg")
        
        self.img.kf.setImage(with: URL.init(string: model.post.user.avatar.isEmpty == false ? model.post.user.avatar : model.topic.user.avatar), placeholder: UIImage(named:"头像@2x.jpg"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        nameLabel.text = model.post.user.nickname.isEmpty == false ? model.post.user.nickname : model.topic.user.nickname
        dateLabel.text = model.post.datestr.isEmpty == false ? model.post.datestr : model.topic.datestr
        
        nameLabel.frame = CGRect(x: img.right + 10, y: img.top, width: UILabel.getStringWidth(text: nameLabel.text!, size: 15), height: 20)
        
        dateLabel.frame = CGRect(x: img.right+10, y: nameLabel.bottom+5, width: UILabel.getStringWidth(text: dateLabel.text!, size: 10), height: 10)
        
        
        // 设置大图数据 和 位置
        self.bigImg.kf.setImage(with: URL.init(string: model.post.middle_pic_url.isEmpty == false ? model.post.middle_pic_url : model.topic.share_pic), placeholder: UIImage(named:"timzwt@2x.jpg"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        if model.post.middle_pic_url.isEmpty == false{
            self.bigImg.frame = CGRect(x: 15, y: img.bottom+20, width: kScreenW-15*2, height: kScreenW-15*2 - 50)
        }else{
         self.bigImg.frame = CGRect(x: 15, y: img.bottom+20, width: kScreenW-15*2, height: (kScreenW-15*2)*165/300)
        }
        
        if model.topic.title.isEmpty == false {
          
            if model.topic.relation.title.isEmpty == false {
                self.relationButton.setTitle("#\(model.topic.relation.title)", for: .normal)
                self.relationButton.frame = CGRect(x: 15, y: bigImg.bottom+10, width: UILabel.getStringWidth(text: "#\(model.topic.relation.title)", size: 10), height: 10)
                
                self.contentLabel.text = model.topic.title
                self.contentLabel.frame = CGRect(x: 15, y: relationButton.bottom+10, width: kScreenW - 15*2, height: 10)
                
                
            }else{
            self.relationButton.setTitle("\(model.topic.relation.title)", for: .normal)
            self.relationButton.frame = CGRect(x: 15, y: bigImg.bottom+10, width: UILabel.getStringWidth(text: "#\(model.topic.relation.title)", size: 10), height: 10)
                
                self.contentLabel.text = model.topic.title
                self.contentLabel.frame = CGRect(x: 15, y: bigImg.bottom+10, width: kScreenW - 15*2, height: 10)
            
            }
        }else{
         
            if model.post.relation.title.isEmpty == false {
                self.relationButton.setTitle("#\(model.post.relation.title)", for: .normal)
                self.relationButton.frame = CGRect(x: 15, y: bigImg.bottom+10, width: UILabel.getStringWidth(text: "#\(model.post.relation.title)", size: 10), height: 10)
                
                self.contentLabel.text = model.post.content
                

                self.contentLabel.frame = CGRect(x: relationButton.right+10, y: relationButton.top, width: kScreenW-15*2 - 80, height: 10)
                
            }else{
                self.relationButton.setTitle("#\(model.post.relation.title)", for: .normal)
                self.relationButton.frame = CGRect(x: 15, y: bigImg.bottom+10, width: UILabel.getStringWidth(text: "#\(model.post.relation.title)", size: 10), height: 10)
            
                self.contentLabel.text = model.post.content
                self.contentLabel.frame = CGRect(x: 15, y: bigImg.bottom+10, width: kScreenW - 15 * 2, height: 10)
            }
        
        
        }
        
        
        if model.topic.title.isEmpty == false {
            self.shareView.frame = CGRect(x: 0, y: self.contentLabel.bottom, width: kScreenW, height: 50)
            self.shareView.send(views: model.topic.views, ispraise: model.topic.ispraise, praises: model.topic.praises)
        }else{
       
            self.shareView.frame = CGRect(x: 0, y: self.contentLabel.bottom, width: kScreenW, height: 50)
            self.shareView.send(views: model.post.dynamic.views, ispraise: model.post.dynamic.ispraise, praises: model.post.dynamic.praises)
        
        }
        
    }
    
    

    
  


}

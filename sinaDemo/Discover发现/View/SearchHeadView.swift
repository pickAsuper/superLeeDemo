//
//  SearchHeadView.swift
//  sinaDemo
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import Kingfisher

private let activityCell = "activityCell"

class SearchHeadView: UIView {

   
    var img = UIImageView()
    var activityArray = Array<ActivityModel>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(colorLiteralRed: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
        
        setupSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupSubviews() {
        img = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 100))
        self.addSubview(img)
        
        let array = ["达人榜","文章榜","晒单榜"]
        let imgArray = ["daren","wenzhang","shaidan"]
        
        for i in 0...2 {
            let btn = UIButton(type: UIButtonType.custom)
            btn.frame = CGRect(x: CGFloat(i) * kScreenW/3, y: img.bottom, width: kScreenW/3, height: 80)
            btn.backgroundColor = UIColor.white
            self.addSubview(btn)
            
            let imgView = UIImageView()
            imgView.frame = CGRect(x: (kScreenW/3-30)/2, y: 15, width: 30, height: 30)
            imgView.image = UIImage(named: imgArray[i])
            btn.addSubview(imgView)
            
            let label = UILabel(frame: CGRect(x: 0, y: imgView.bottom+10, width: kScreenW/3, height: 20))
            label.font = UIFont.systemFont(ofSize: 14)
            label.textAlignment = .center
            label.text = array[i]
            btn.addSubview(label)
            
            
        }
        
        let title = UILabel(frame: CGRect(x: 0, y: img.bottom+90, width: kScreenW, height: 40))
        title.font = UIFont.systemFont(ofSize: 15)
        title.textAlignment = .center
        title.textColor = UIColor.darkText
        title.text = "热门活动"
        title.backgroundColor = UIColor.white
        self.addSubview(title)
        
    
    }

    func sendModel(model: DiscoverSearchModel) {
        
        for model : SearchBannerModel in model.banner {
//            print(model.photo)
            
        }
        
        for model1 : ActivityModel in model.activity_list {
//            print(model1.icon)
            
        }
        
        
        img.kf.setImage(with: URL(string: "http://up.qqjia.com/z/17/tu17742_2.jpg"), placeholder: UIImage(named:""), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        self.activityArray = model.activity_list
        
        var height  = CGFloat()
        let count = self.activityArray.count%2
        if count == 0 {
            height = CGFloat(self.activityArray.count/2*80)
        }else{
          height = CGFloat(self.activityArray.count/2 + 1) * 80
        }
        
        // 添加下面的四个按钮 用collectionView 布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenW-1)/2, height: 80)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0)
        
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: img.bottom+130, width: kScreenW, height: height) , collectionViewLayout: layout)
        collectionView.register(ActivityCell.self, forCellWithReuseIdentifier: activityCell)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        self.addSubview(collectionView)
        
    }
    
    
}


extension SearchHeadView: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: activityCell, for: indexPath) as! ActivityCell
        cell.sendModel(model: self.activityArray[indexPath.item])
    
        return cell
    }


}

//
//  AllSubcateVC.swift
//  sinaDemo
//
//  Created by admin on 17/4/11.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

private let kItemW : CGFloat = (kScreenW - 6 * kItemMargin) / 3
private let kItemH : CGFloat = 30
private let kSubcataCellID : String = "kSubcataCellID"

typealias backChangeBlock = ([GameModel]) -> ()

class AllSubcateVC: UIViewController {

    // 频道数组的Block
    var channelBlock : backChangeBlock?
    
    // 未选择的频道
    fileprivate lazy var unselectedChannels = [GameModel]()
    
    // 已选择的频道
    fileprivate lazy var selectedChannels = [GameModel]()
    
    // 频道数
    fileprivate lazy var channels = [GameModel]()
    
    
    
    fileprivate lazy var collectionView : UICollectionView = {
      
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = kItemMargin
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: kItemMargin, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)
        
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(CollectionSubcateCell.self, forCellWithReuseIdentifier: kSubcataCellID)


        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadView")
        
//          这个手势代码有bug 会出现不能还原item位置的问题
//        let gesture = UILongPressGestureRecognizer.init(target: self, action: #selector(viewCustom(_ :)))
//        
//        collectionView.addGestureRecognizer(gesture)
        
        return collectionView
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let selected = common.unarchiveData(appendPath: SELECTED_CHANNELS)
        let unselected = common.unarchiveData(appendPath: UNSELECTED_CHANNELS)
        
        if (selected == nil)||(unselected == nil){
           requestData()
        }else{
           self.selectedChannels = selected!
           self.unselectedChannels = unselected!
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        var selectCate : [GameModel] = [GameModel]()
        
        if channels.count > 0 {
            self.channelBlock!(channels)
            selectCate = channels
            common.archiveData(channel: channels, appendPath: SELECTED_CHANNELS)
            
        }else{
            if (self.selectedChannels.count > 0) {
                self.channelBlock!(self.selectedChannels)
                selectCate = self.selectedChannels
                common.archiveData(channel: self.selectedChannels, appendPath: SELECTED_CHANNELS)
                
            }else{
               self.channelBlock!([GameModel]())
               common.archiveData(channel: [GameModel](), appendPath: UNSELECTED_CHANNELS)
            }
        
        }
        common.archiveData(channel: self.unselectedChannels, appendPath: UNSELECTED_CHANNELS)
        NotificationCenter.default.post(name: NotifyUpdateCategory , object: nil, userInfo: [KSelectedChannel :selectCate])
        
        
    }
    
}


extension AllSubcateVC{
   
    @objc fileprivate func viewCustom(_ longPress:UILongPressGestureRecognizer){

        let  point: CGPoint = longPress.location(in: longPress.view)

        guard let indexpath = self.collectionView.indexPathForItem(at: point)else{ return }
        switch longPress.state {
        case .began:
            
            self.collectionView.beginInteractiveMovementForItem(at: indexpath)
            break
        case .changed:
            self.collectionView.updateInteractiveMovementTargetPosition(point)
            break
            
        case.ended:
            self.collectionView.endInteractiveMovement()
            break
        default:
            self.collectionView.cancelInteractiveMovement()
            break
        }

    }
    
}

extension AllSubcateVC{
 
    fileprivate func setupUI(){
      view.backgroundColor = UIColor.white
      title = "频道选择"
      view.addSubview(collectionView)
    
        
        
    }
    
    fileprivate func requestData(){
        
        NetworkTool.request(type: .GET, urlString: "http://api.m.panda.tv/ajax_get_all_subcate", paramters: ["__version":"1.1.7.1305", "__plat":"ios", "__channel":"appstore"]) { (result) in
            
            
            guard let resultDict = result as? [String : NSObject] else{ return }
            
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            
            for dict in dataArray {
             
              let allSubcate = GameModel(dict: dict)
              self.unselectedChannels.append(allSubcate)
                
            }
            self.collectionView.reloadData()
        
            }
     }
}

extension AllSubcateVC : UICollectionViewDelegate ,UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.selectedChannels.count
        }else{
            return self.unselectedChannels.count
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 这里需要注意的是 用as 来确定是什么cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSubcataCellID, for: indexPath) as! CollectionSubcateCell
        
        if indexPath.section == 0 {
          
            cell.subcateModel = self.selectedChannels[indexPath.item]
        }else{
            
            cell.subcateModel = self.unselectedChannels[indexPath.item]
        }
        
        
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeadView", for: indexPath) as! HeaderView
        
        if indexPath.section == 0 {
            
           // headView.title = "常用频道(长按可拖动调整频道顺序，点击删除)"
            headView.title = "常用频道"

        }else{
            
            headView.title = "所有频道(点击添加您感兴趣的频道)"
            
        }
        
        let attributeStr = NSMutableAttributedString(string: headView.title)
        
        attributeStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14.0), range: NSMakeRange(0, 4))
        
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSMakeRange(0, 4))
        
        headView.label.attributedText = attributeStr
        
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if indexPath.section == 1 {
            
            self.selectedChannels.append(self.unselectedChannels[indexPath.item])
            self.unselectedChannels.remove(at: indexPath.item)
            
            let indexPath1 = NSIndexPath.init(item: selectedChannels.count - 1, section: 0)
            let indexPath2 = NSIndexPath.init(item: indexPath.item, section: 1)
            
            collectionView.moveItem(at: indexPath2 as IndexPath, to: indexPath1 as IndexPath)
            
        }else{
            
            self.unselectedChannels.append(self.selectedChannels[indexPath.item])
            self.selectedChannels.remove(at: indexPath.item)
            let path1 = NSIndexPath.init(item: unselectedChannels.count - 1, section: 1)
            let path2 = NSIndexPath.init(item: indexPath.item, section: 0)
            collectionView.moveItem(at: path2 as IndexPath, to: path1 as IndexPath)
            
        }
        self.collectionView.reloadData()
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenW, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
              return true
        }else{
             return false
        }
    }
 
    
    // MARK - 手势拖动触发
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == 0 && destinationIndexPath.section == 0 {
            collectionView.exchangeSubview(at: sourceIndexPath.item, withSubviewAt: destinationIndexPath.item)
            
//            print(sourceIndexPath.item)
//            print(destinationIndexPath.item)
            
            
        }
        
        let array = NSMutableArray(array: self.selectedChannels)
        
        array.exchangeObject(at: sourceIndexPath.item, withObjectAt: destinationIndexPath.item)
        
        for model in array {
            self.channels.append(model as! GameModel)
        }
        
        

    }
    
    
}



class HeaderView: UICollectionReusableView {
    
    lazy var line : UIView = {
      let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 10))
        view.backgroundColor = BGCOLOR
      return view
    }()
    
    lazy var label : UILabel = {
      let label = UILabel(frame: CGRect(x: 10, y: 10, width: kScreenW - 10, height: self.bounds.size.height - 10))
        
        label.textColor = UIColor.lightGray
        
        // adjustsFontSizeToFitWidth 自适应label的宽度
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 12.0)
      return label
    }()
    
    var title = "" {
        
        didSet{
            label.text = title
        }
    
    }
    
   override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(line)
        addSubview(label)
    
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


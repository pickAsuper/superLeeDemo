//
//  LCSuperMapViewController.swift
//  sinaDemo
//
//  Created by admin on 2017/5/23.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCSuperMapViewController: UIViewController {

    // 地图层
    var _mapView : BMKMapView?
    
    // 定位服务
    var locationService : BMKLocationService!
    
    // 底部的View
    var bottomView : LCSuperMapBottomView = {
     let bottomView = LCSuperMapBottomView()
         bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
         bottomView.frame = CGRect(x: 0, y: kScreenH - 40, width: kScreenW, height: 40)
         return bottomView
    
    }()
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView?.viewWillAppear()
        _mapView?.delegate = self
      
//        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        self.navigationController?.navigationBar.hideBottomHairline()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView?.viewWillDisappear()
        
        // 不用时，置nil
        _mapView?.delegate = nil
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
            // 地图标注
//         let annotation = BMKPointAnnotation()
//         var coor = CLLocationCoordinate2D()
//  
//         coor.latitude = 39.915;
//         coor.longitude = 116.404;
//        
//         annotation.coordinate = coor
//         annotation.title = "这是北京"
//        
//        _mapView?.addAnnotation(annotation)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.white

        // 先设置地图 在设置UI子控件
        setupMapView()

        setupUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


extension LCSuperMapViewController {
  
    func setupUI(){
    
        bottomView.oneButton.addTarget(self, action: #selector(oneButtonItemClick(_ :)), for: .touchUpInside)
        bottomView.twoButton.addTarget(self, action: #selector(twoButtonItemClick(_ :)), for: .touchUpInside)
        bottomView.threeButton.addTarget(self, action: #selector(threeButtonItemClick(_ :)), for: .touchUpInside)

        

    }
    
    // MAKE -设置地图的View
    func setupMapView(){
    
    
        _mapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        
        // 设置地图类型 Satellite ->卫星图
        _mapView?.mapType = UInt(BMKMapTypeStandard)
        
        // 打开实时路况图层
        _mapView?.isTrafficEnabled = false
        
        // 打开百度城市热力图图层（百度自有数据）
        //        _mapView?.isBaiduHeatMapEnabled = true
        
        
        // 显示定位
        _mapView?.showsUserLocation = false//先关闭显示的定位图层
        _mapView?.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
       // _mapView?.showsUserLocation = true//显示定位图层
        
        self.view.addSubview(_mapView!)
        
        let displayPara = BMKLocationViewDisplayParam()
            displayPara.isRotateAngleValid = false
            displayPara.isAccuracyCircleShow = false
            displayPara.locationViewOffsetX = 0
            displayPara.locationViewOffsetY = 0
        _mapView?.updateLocationView(with: displayPara)
        
        
        locationService = BMKLocationService()
        locationService.startUserLocationService()
        
        locationService.delegate = self
        
        // 指定定位：是否允许后台定位更新。默认为NO。只在iOS 9.0之后起作用。设为YES时，Info.plist中 UIBackgroundModes 必须包含 "location"
        locationService.allowsBackgroundLocationUpdates = true

        self.view.addSubview(bottomView)


    }


}

extension LCSuperMapViewController {

    
    // 定位
    func oneButtonItemClick(_ sender: UIButton){
    
        sender.isSelected = !sender.isSelected
       
        if sender.isSelected {
                _mapView?.showsUserLocation = true
        }else{
                _mapView?.showsUserLocation = false
        }

    
    }
  
    func twoButtonItemClick(_ sender: UIButton){
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            _mapView?.isTrafficEnabled = true
            
        }else{
            _mapView?.isTrafficEnabled = false
            
        }
        

        
    }
    
    // 标准/卫星图
    func threeButtonItemClick(_ sender: UIButton){
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            _mapView?.mapType = UInt(BMKMapTypeSatellite)
            
        }else{
            _mapView?.mapType = UInt(BMKMapTypeStandard)
            
        }
        
    }
}

// 地图代理
extension LCSuperMapViewController:BMKMapViewDelegate {

    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation.isKind(of: BMKPointAnnotation.self) {
            let newAnnotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
                newAnnotationView?.pinColor = UInt(BMKPinAnnotationColorPurple)
                newAnnotationView?.animatesDrop = true
               return newAnnotationView
            
        }
        return nil
    }

}


// 定位
extension LCSuperMapViewController : BMKLocationServiceDelegate{

    /**
     *在地图View将要启动定位时，会调用此函数
     *@param mapView 地图View
     */
    func willStartLocatingUser() {
        print("willStartLocatingUser");
    }

    
    // 用户方向更新后，会调用此函数
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        
        print(userLocation.heading)
        _mapView?.updateLocationData(userLocation)

    }
    func didUpdate(_ userLocation: BMKUserLocation!) {
       
        print(userLocation.location.coordinate.latitude)
        
        print(userLocation.location.coordinate.longitude)
       
        _mapView?.updateLocationData(userLocation)
        
    }
    
    /**
     *在地图View停止定位后，会调用此函数
     *@param mapView 地图View
     */
    func didStopLocatingUser() {
        print("didStopLocatingUser")
    }

    
}


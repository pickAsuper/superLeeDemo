//
//  LCLoginViewController.swift
//  sinaDemo
//
//  Created by admin on 17/4/20.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class LCLoginViewController: UIViewController {

    var initialOffset:CGFloat = 0.0
    
    
    // 懒加载 控制器
    lazy var LCFAChildVC : FAChildVC = FAChildVC()
    
    
    lazy var bgImageView : UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "FAImage.jpg")
        bgImageView.frame = CGRect(x: -30, y: 0, width: kScreenW * 3 + 30, height: kScreenH)
        return bgImageView
        
    }()

    
    lazy var bgView : UIView = {
     let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return bgView
        
    }()
    
    
    lazy var scrollView : UIScrollView = {
      let scrollView = UIScrollView()
          scrollView.delegate = self
          scrollView.bounces = false
          scrollView.isPagingEnabled = true
          scrollView.alpha = 1
          scrollView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
          scrollView.contentSize = CGSize(width: kScreenW * 4, height: kScreenH)
          scrollView.showsHorizontalScrollIndicator = false
      return scrollView
    
    }()
    
    
    lazy var pageView : UIPageControl = {
     let pageView = UIPageControl()
        pageView.frame = CGRect(x: self.view.center.x - 50, y: kScreenH - 120, width: 100, height: 20)
        return pageView
        
    }()
    
    // 注册按钮
    lazy var signUPBtn :UIButton = {
        let signUPBtn = UIButton()
            signUPBtn.frame = CGRect(x: 40, y: kScreenH - 80 , width: (kScreenW - 40 - 40 - 20) * 0.5, height: 40)
            signUPBtn.backgroundColor = UIColor.init(r: 61, g: 59, b: 65)
            signUPBtn.setTitle("Sign Up", for: .normal)
            signUPBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            signUPBtn.addTarget(self, action: #selector(signUPBtnClick), for: .touchUpInside)
        return signUPBtn
        
    }()
    
    // 登录按钮
    lazy var loginBtn :UIButton = {
        let loginBtn = UIButton()
            loginBtn.frame = CGRect(x: kScreenW - ((kScreenW - 40 - 40 - 20) * 0.5) - 40, y: kScreenH - 80 , width: (kScreenW - 40 - 40 - 20) * 0.5, height: 40)
            loginBtn.backgroundColor = UIColor.init(r: 186, g: 150, b: 63)
            loginBtn.setTitle("Login", for: .normal)
            loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)

        return loginBtn
        
    }()
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
//        self.LCFAChildVC.view.removeFromSuperview()
        
    }
    
    // 为了控制导航栏的状态颜色 和 线
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        UIApplication.shared.statusBarStyle = .lightContent

        
        // 隐藏导航栏底线
        let navigationBar = self.navigationController?.navigationBar
            navigationBar?.hideBottomHairline()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // 显示导航栏底线
        let navigationBar = self.navigationController?.navigationBar
            navigationBar?.showBottomHairline()
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startAnimating()

    }
   
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
         viewConfigurations()
        
    }
 
   
 
     // MARK: - view的配置
    private func viewConfigurations(){
        addObservers()
        configureChildVCs()

    }
    
     // MARK: - 监听
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(startAnimating), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
    }
    
    
    // MARK: - 配置子控制器
    func configureChildVCs() {
       let totalVCs = 4
        self.pageView.numberOfPages = totalVCs
        
        for index in 0..<totalVCs {
            let childVC:FAChildVC = childVCfor(index: index)
            addInScollView(childVC: childVC)
        }
        
        
    }
    
    // 把控制器的View添加到scrollView上
    func addInScollView(childVC:FAChildVC) {
        childVC.willMove(toParentViewController: self)
        scrollView.addSubview(childVC.view)
        childVC.didMove(toParentViewController: self)
    }
    

    private func childVCfor(index:NSInteger) -> FAChildVC {
//        self.LCFAChildVC = FAChildVC()
        var rect:CGRect = UIScreen.main.bounds
        rect.origin.x =  0
        self.LCFAChildVC.view.frame = rect
      
        return self.LCFAChildVC
    }
    
    
    // MARK: - 开始动画
    func startAnimating() {
        if bgImageView.layer.animation(forKey: "center")  == nil {
            bgImageView.layer.add(animationForXAxis(), forKey: "center")
        }
    }
    
    // MARK: - 状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
          return .lightContent
        }
    }
    
    // MARK: -执行动画
    func animationForXAxis() -> CABasicAnimation{
        let animation: CABasicAnimation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.byValue = 30
        animation.duration = 3.0
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        return animation
        
    }
    
    // MARK: - 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension LCLoginViewController {
    func setupUI() {
   
        // 添加各个控件
        self.view.addSubview(self.bgImageView)
        self.view.addSubview(self.bgView)
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageView)
        self.view.addSubview(self.signUPBtn)
        self.view.addSubview(self.loginBtn)

    }

}

extension LCLoginViewController :UIScrollViewDelegate{

    
    // 计算偏移量
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var center = self.bgImageView.center
        center.x = center.x - (scrollView.contentOffset.x - initialOffset)/3
        bgImageView.center = center
        initialOffset = scrollView.contentOffset.x
        
    }
   
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageView.currentPage = NSInteger(scrollView.contentOffset.x) / NSInteger(scrollView.frame.size.width)
    }

}



extension LCLoginViewController {

    // 注册按钮点击事件
    func signUPBtnClick(){
    
    
    
    }
    // 登陆按钮点击事件
    func loginBtnClick(){
    
        
    }
    
    
    
}


//extension UINavigationBar {
//    func hideBottomHairline() {
//        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
//        navigationBarImageView!.isHidden = true
//    }
//    func showBottomHairline() {
//        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
//        navigationBarImageView!.isHidden = false
//    }
//    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
//        if view.isKind(of: UIImageView.self) &&  view.bounds.height <= 1.0{
//             return (view as! UIImageView)
//        }
//
//        let subviews = (view.subviews as [UIView])
//        for subview: UIView in subviews {
//            if let imageView: UIImageView = hairlineImageViewInNavigationBar(view: subview) {
//                return imageView
//            }
//        }
//        return nil
//    }
//}
//
//extension UIToolbar {
//    
//    func hideHairline() {
//        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
//        navigationBarImageView!.isHidden = true
//    }
//    
//    func showHairline() {
//        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
//        navigationBarImageView!.isHidden = false
//    }
//    
//    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
//        if view.isKind(of: UIImageView.self) &&  view.bounds.height <= 1.0{
//            return (view as! UIImageView)
//        }
//        let subviews = (view.subviews as [UIView])
//        for subview: UIView in subviews {
//            if let imageView: UIImageView = hairlineImageViewInToolbar(view: subview) {
//                return imageView
//            }
//        }
//        return nil
//    }
//}


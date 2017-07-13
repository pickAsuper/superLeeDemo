//
//  LCWebPageViewController.swift
//  sinaDemo
//
//  Created by admin on 2017/5/22.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import WebKit

class LCWebPageViewController: UIViewController {

    var urlString = String()
    
    // 进度条
    lazy var progressView : UIProgressView = {
      
        let progressView = UIProgressView(frame:CGRect(x: 0, y: 0, width: kScreenW, height: 20))
            progressView.progress = 0.0
            progressView.tintColor = UIColor.orange
            self.webView.addSubview(progressView)
        return progressView
    
    }()
    
    // next按钮
    lazy var rightBarButton : UIButton = {
        let rightBarButton = UIButton()
        rightBarButton.setTitle("next", for: .normal)
        rightBarButton.frame = CGRect(x: 0, y: 0, width:80, height: 40)
        rightBarButton.setTitleColor(UIColor.orange, for: .normal)
        rightBarButton.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        return rightBarButton
        
    }()

    
    // back按钮
    lazy var backBarButton : UIButton = {
        let backBarButton = UIButton()
        backBarButton.setTitle("back", for: .normal)
        backBarButton.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        backBarButton.setTitleColor(UIColor.orange, for: .normal)
        backBarButton.addTarget(self, action: #selector(backBarButtonItemClick), for: .touchUpInside)
        return backBarButton
        
    }()

    
    var webView :WKWebView = {
        
       let  webView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
//        webView.
        
         return webView
    }()
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        self.navigationController?.navigationBar.barTintColor = UIColor.orange.withAlphaComponent(0.6)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navigationbarBackgroundWhite"), for: UIBarMetrics.default)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.red]
        
        
    }
    
    // 一定要移除监听
    override func viewWillDisappear(_ animated: Bool) {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()

        self.view.backgroundColor = UIColor.white
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
       
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.webView.load(request)
        self.view.addSubview(self.webView)
      
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)

        
        //     NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML;"];
        //     DLog(@"html > %@  <",html);
        
        
        
        
    }

    
    func setNavBar() {

        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBarButton)

        
        /*
         // 设置导航栏的背景颜色
         self.navigationController.navigationBar.barTintColor = UIColor.redColor()
         
         // 设置导航栏标题的字体颜色(1)
         self.navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont("字体名", ofSize: 15)]
         
         // 设置导航栏标题的字体颜色(2)
         设置navigationItem的titleView 通过view中的label属性去改变字体和颜色  self.navigationItem.titleView
         
         // 设置导航栏的按钮图标等的颜色(ToolBar)
         self.navigationController.navigationBar.tintColor = UIColor.orangeColor()
         */
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    

}

// MAKE - 跳转事件
extension LCWebPageViewController {

    func rightBarButtonItemClick() {
       
        if self.webView.canGoForward {
            self.webView.goForward()
        }

    }

    func backBarButtonItemClick() {
        
        if self.webView.canGoBack {
            self.webView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // 监听进度条
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)

             // 进度条的值最大为1.0
            if(self.webView.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.5, animations: { 
                    self.progressView.alpha = 0.0

                }, completion: { (finished) in
                    self.progressView.progress = 0

                })
                
                           
            }
        
        }
        
    }
}


// MAKE - WKNavigationDelegate
extension LCWebPageViewController:WKNavigationDelegate  {

    // linkActivated,//链接的href属性被用户激活。
    
    /*
         linkActivated   链接的href属性被用户激活
         formSubmitted   一个表单提交。
         backForward     回到前面的条目列表请求
         reload          网页加载
         formResubmitted 一个表单提交(例如通过前进,后退,或重新加载)
         other           导航是发生一些其他原因
     */
    
    // 决定网页能否被允许跳转
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
//        
//        if (navigationAction.navigationType == .linkActivated){
//            decisionHandler(.cancel)
//        } else {
//            decisionHandler(.allow)
//        }
//        
//    }
    

    // 准备加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 开始加载
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
       
        
    }
   
    // 完成加载
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      
        self.navigationItem.title = self.webView.title
        
        // 获取整个网页
//        webView.evaluateJavaScript("document.getElementsByTagName('html')[0].outerHTML;") { (res, error) in
//           
//            
//            print(res)
//            
//            print(error)
//
//        }

        webView.evaluateJavaScript("document.title") { (res, error) in
            
            print(res)
            
            self.title = res as? String
        }
     
    
    }
    
    // 处理网页返回内容时发生的失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    // 处理网页加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        
    }
    
    // 处理网页进程终止
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
        
    }
    
    // iOS9.0中新加入的,处理WKWebView关闭的时间
    func webViewDidClose(_ webView: WKWebView) {
        
        
    }
    
    // 处理网页js中的提示框,若不使用该方法,则提示框无效
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        if let host = self.webView.url?.host {
            let alertController = UIAlertController(title: host, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("close", comment: "嗷嗷"), style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction!) in
                completionHandler()
            }))
            
            self.present(alertController, animated: true, completion: nil)
        
        }
    }
    
    // 处理网页js中的确认框,若不使用该方法,则确认框无效
    func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void){
    
        if let host = self.webView.url?.host {
            let alertController = UIAlertController(title: host, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("close", comment: "嗷嗷"), style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction!) in
                completionHandler(true)
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // 处理网页js中的文本输入
    func webView(webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void){
    
        if let host = self.webView.url?.host {
            let alertController = UIAlertController(title: prompt, message: host, preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField: UITextField!) in
                textField.text = defaultText
            })
           
            alertController.addAction(UIAlertAction(title: NSLocalizedString("ok_button", comment: "ok"), style: .default, handler: { (action: UIAlertAction!) in
                if let input = alertController.textFields?.first?.text {
                    completionHandler(input)
                }
            }))
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: "嗷嗷"), style: .default, handler: { (action: UIAlertAction!) in
                completionHandler(nil)
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        
    
    }
    
}


// MAKE - WKUIDelegate
extension LCWebPageViewController :WKUIDelegate{

//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
    
//        // 如果目标主视图不为空,则允许导航
//        if !(navigationAction.targetFrame?.isMainFrame != nil) {
//            self.webView.load(navigationAction.request)
//        }
//        return nil
//    }
    
}
 

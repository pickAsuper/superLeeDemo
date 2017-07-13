//
//  NetworkTool.swift
//  sinaDemo
//
//  Created by admin on 17/4/11.
//  Copyright © 2017年 super. All rights reserved.

//   首页网络请求的工具类

import UIKit
import Alamofire

enum MethodType{
    case GET
    case POST
}

class NetworkTool: NSObject {

    class func request(type : MethodType ,urlString : String , paramters: [String :Any]? = nil,finishedCallback : @escaping (_ result : Any) -> ()) {
       
        //判断是什么类型的请求
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        // 发送网络请求
        Alamofire.request(urlString , method: method, parameters: paramters).responseJSON { (response) in
            
            guard let result = response.result.value else{
                print(response.result.value)
                return
            }
            
            // 回调
            finishedCallback(result as AnyObject)
        }
    }
}
    


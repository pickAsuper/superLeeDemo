//
//  NetRequest.swift
//  sinaDemo
//
//  Created by admin on 2017/4/28.
//  Copyright © 2017年 super. All rights reserved.


//   发现的获取数据的工具类

import UIKit
import Alamofire

private let NetRequestShareInstance = NetRequest()

class NetRequest: NSObject {
    class var shareInstance : NetRequest {
        return NetRequestShareInstance
    }
    
}


extension NetRequest {

    
    // urlString   url
    // params      参数
    // finished    回调
    func getRequest(urlString : String, params: [String : Any]? = nil, finished : @escaping (_ response : [String : AnyObject]?,_ error : NSError?) -> ()) {
        
          Alamofire.request(urlString, method: .get, parameters: params)
                .responseJSON { (response) in
                    
                    if response.result.isSuccess{
                        
                        finished(response.result.value as? [String : AnyObject],nil)
                    }else{
                        
                        finished(nil,response.result.error as NSError?)
                        
                    }
            }
      }

    func getIDRequest(urlString : String, params: [String : Any]? = nil, finished : @escaping (_ response : AnyObject,_ error : NSError?) -> ()) {
        
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response) in
                
              

                
                if response.result.isSuccess{
                    
                    finished(response.result.value as AnyObject ,nil)
                }else{
                    
                    finished(response as AnyObject ,response.result.error as NSError?)
                    
                }
        }
    }

}




extension NetRequest {
    func postRequest(urlString : String ,params : [String : Any], finished : @escaping (_ response : [String : Any]?,_ error: NSError?)->()) {
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { (response) in
            if response.result.isSuccess{
                
                finished(response.result.value as? [String : AnyObject],nil)
                
            }else{
                
                finished(nil,response.result.error as NSError?)
                
            }
            
            
        }
}

}


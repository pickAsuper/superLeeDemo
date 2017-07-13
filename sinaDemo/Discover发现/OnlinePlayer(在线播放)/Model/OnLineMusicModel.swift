//
//  OnLineMusicModel.swift
//  sinaDemo
//
//  Created by super on 2017/5/20.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON

class OnLineMusicModel: NSObject {
    

    
    var status  = String()
    var artistId  = String()
    var albumName  = String()
    var songName  = String()
    var enhancement  = String()
    var artistName  = String()
    var songLink  = String()
    var showLink  = String()
    var version  = String()
    var format  = String()
    var linkinfo  = String()

    var albumId = Int()
    var size = Int()
    var songId = Int()
    var time = Int()
    var linkCode = Int()
    var copyType = Int()
    var lrcLink = String()
    var queryId = Int()
    var rate  = Int()

    init(dict : JSON) {
        super.init()

        self.status = dict["status"].stringValue
        self.artistId = dict["artistId"].stringValue
        self.albumName = dict["albumName"].stringValue
        self.songName = dict["songName"].stringValue
        self.enhancement = dict["enhancement"].stringValue
        self.artistName = dict["artistName"].stringValue
        self.songLink = dict["songLink"].stringValue
        self.showLink = dict["showLink"].stringValue
        self.albumName = dict["albumName"].stringValue
        self.version = dict["version"].stringValue
        self.format = dict["format"].stringValue
        self.linkinfo = dict["linkinfo"].stringValue
        self.lrcLink = dict["lrcLink"].stringValue

        
        self.albumId = dict["albumId"].intValue
        self.size = dict["size"].intValue
        self.songId = dict["songId"].intValue
        self.time = dict["time"].intValue
        self.linkCode = dict["linkCode"].intValue
        self.copyType = dict["copyType"].intValue
        self.queryId = dict["queryId"].intValue
        self.rate = dict["rate"].intValue

    }
    

/*
     {
     "data" : {
     "xcode" : "eeb57f55c362bc90b91093c56fdd9bfa",
     "time" : 3600,
     "songList" : [
     {
            "status" : 1,
            "songId" : 14920571,
            "time" : 275,
            "linkCode" : 22000,
            "artistId" : "188",
            "albumName" : "Uncontrolled",
             "copyType" : 1,
             "songName" : "tempest",
             "enhancement" : "0.000000",
            "artistName" : "安室奈美惠",
             "songLink" : "http:\/\/yinyueshiting.baidu.com\/data2\/music\/41930462\/149205711495245661128.mp3?xcode=a99be7ba26137bdc2a1779a2a81a9c08",
            "showLink" : "http:\/\/pan.baidu.com\/share\/link?shareid=2847156881&uk=4015246675",
             "albumId" : 14920574,
             "size" : 4407514,
             "version" : "",
         "lrcLink" : "http:\/\/musicdata.baidu.com\/data2\/lrc\/14924804\/14924804.lrc",
         "queryId" : "14920571",
         "format" : "mp3",
         "rate" : 128,
         "linkinfo" : null
     
     }
     ]
     },
     "errorCode" : 22000
     }

     */
    
    
    
}

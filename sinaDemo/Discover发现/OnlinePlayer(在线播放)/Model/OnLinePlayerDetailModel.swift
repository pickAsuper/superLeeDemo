//
//  OnLinePlayerDetailModel.swift
//  sinaDemo
//
//  Created by admin on 2017/5/19.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit
import SwiftyJSON

class OnLinePlayerDetailModel: NSObject {
  
    
    var korean_bb_song = Int()
    var yyr_artist_id = String()
    var si_presale_flag = String()
    var musician = Int()
    var resource_type_ext = Int()
    var song_links = Array<Any>()

    var relateStatus = String()
    var has_mv = Int()
    var sid = Int()
  
    var albumName = String()
    var publishtime = String()
    var beDownloaded = Int()
   
    var songPicRadio = String()
    var resourceType = String()
    var allRate = String()
    var encryptedSongid = String()
   
    var area = Int()
    var songId = String()
    var songPicBig = String()

    var del_status = Int()
    var compress_status = Int()
    var source  = String()
    var baidu_has = Int()

    
    
    var artistId  = String()
    var isJump = Int()
    var artistName  = String()
    var fchar  = String()
   
    var tingUid = Int()
    var bePlayed = Int()
    var songPicSmall  = String()
    var bitrate_fee  = String()
    var albumId = Int()
    var si_market_price  = String()
    var si_price  = String()
    var bePaged = Int()
    var distribution  = String()

    var queryId  = String()
    var songName  = String()
    var resource_provider  = String()
    var beCollected = Int()

    init(dict:JSON) {
        self.korean_bb_song = dict["korean_bb_song"].intValue
        self.yyr_artist_id = dict["yyr_artist_id"].stringValue
        self.si_presale_flag = dict["si_presale_flag"].stringValue
        
        self.musician = dict["musician"].intValue
        self.resource_type_ext = dict["resource_type_ext"].intValue
        self.song_links = dict["song_links"].arrayValue
        
        self.relateStatus = dict["relateStatus"].stringValue
        self.has_mv = dict["has_mv"].intValue
        self.sid = dict["sid"].intValue
        
        self.albumName = dict["albumName"].stringValue
        self.publishtime = dict["publishtime"].stringValue
        self.beDownloaded = dict["beDownloaded"].intValue
    
        
        self.songPicRadio = dict["songPicRadio"].stringValue
        self.resourceType = dict["resourceType"].stringValue
        self.allRate = dict["allRate"].stringValue
        self.encryptedSongid = dict["encryptedSongid"].stringValue
        
        self.area = dict["area"].intValue
        self.songId = dict["songId"].stringValue
        self.songPicBig = dict["songPicBig"].stringValue

        self.del_status = dict["del_status"].intValue
        self.compress_status = dict["compress_status"].intValue
        self.source = dict["source"].stringValue
        self.baidu_has = dict["baidu_has"].intValue
        
        self.artistId = dict["artistId"].stringValue
        self.isJump = dict["isJump"].intValue
        self.artistName = dict["artistName"].stringValue
        self.fchar = dict["fchar"].stringValue
        
        self.tingUid = dict["tingUid"].intValue
        self.bePlayed = dict["bePlayed"].intValue
        self.songPicSmall = dict["songPicSmall"].stringValue
        self.bitrate_fee = dict["bitrate_fee"].stringValue
        
        self.albumId = dict["albumId"].intValue
        self.si_market_price = dict["si_market_price"].stringValue
        self.si_price = dict["si_price"].stringValue
        self.bePaged = dict["bePaged"].intValue
        self.distribution = dict["distribution"].stringValue

        
        self.queryId = dict["queryId"].stringValue
        self.songName = dict["songName"].stringValue
        self.resource_provider = dict["resource_provider"].stringValue
        self.beCollected = dict["beCollected"].intValue
        
    }
    
    
    
    /*
        1 "korean_bb_song" : 0,
        2 "yyr_artist_id" : "",
        3 "si_presale_flag" : "0",
        4  "musician" : 0,
         5 "resource_type_ext" : 0,
         6 "song_links" : [
     
          ],
         7  "relateStatus" : "1",
         8 "has_mv" : 0,
         9 "sid" : 0,
        1 "albumName" : "妹力四射",
         2"publishtime" : "1997-12-20",
         3   "beDownloaded" : 0,
          4"songPicRadio" : "http:\/\/musicdata.baidu.com\/data2\/pic\/88568107\/88568107.jpg@s_0,w_300",
           "resourceType" : "2",
           "allRate" : "24,64,128,192,208,256,320",
           "encryptedSongid" : "8306105b540858f5fb7a",
         "area" : 4,
         "songId" : "1071956",
         "songPicBig" : "http:\/\/musicdata.baidu.com\/data2\/pic\/88568107\/88568107.jpg@s_0,w_150",
          "del_status" : 1,
           "compress_status" : 1,
           "source" : "web",
          "baidu_has" : 1,
           "artistId" : "1071",
          "isJump" : 0,
          "artistName" : "张惠妹",
         "fchar" : "Z",
         "tingUid" : 1071,
        "bePlayed" : 0,
         "songPicSmall" : "http:\/\/musicdata.baidu.com\/data2\/pic\/88568107\/88568107.jpg@s_0,w_90",
         "bitrate_fee" : "{\"0\":\"0|0\",\"1\":\"0|0\"}",
     "albumId" : 193774,
     "si_market_price" : "0.00",
     "si_price" : "0.00",
     "bePaged" : 0,
     "distribution" : "0000000000,0000000000,0000000000,0000000000,0000000000,0000000000,0000000000,1111111111,1111111111,0000000000",
     "queryId" : "1071956",
     "songName" : "You Make Me Free",
     "resource_provider" : "0",
     "beCollected" : 0
     
     */
    
    
}

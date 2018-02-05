//
//  JKModel.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import HandyJSON
import ObjectMapper


struct CommonResult: HandyJSON {
    var error: Bool?
    var results: [GankData]?
}

struct GankData: HandyJSON {
    var _id: String?
    var createdAt: Bool?
    var desc: String?
    var publishedAt: String?
    var source: String?
    var type: String?
    var url: String?
    var used: Bool?
    var who: String?
}

//struct JKModel: HandyJSON {
//    var _id: String?
//    var createdAt: Bool?
//    var desc: String?
//    var publishedAt: String?
//    var source: String?
//    var type: String?
//    var url: String?
//    var used: Bool?
//    var who: String?
//}

struct JKModel: Mappable {
    var _id         = ""
    var createdAt   = ""
    var desc        = ""
    var publishedAt = ""
    var source      = ""
    var type        = ""
    var url         = ""
    var used        = ""
    var who         = ""
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        _id         <- map["_id"]
        createdAt   <- map["createdAt"]
        desc        <- map["desc"]
        publishedAt <- map["publishedAt"]
        source      <- map["source"]
        type        <- map["type"]
        url         <- map["url"]
        used        <- map["used"]
        who         <- map["who"]
    }
}

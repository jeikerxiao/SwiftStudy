//
//  Post.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
//import ObjectMapper
import HandyJSON

/*
class Post: Mappable {
    var id: Int?
    var title: String?
    var body: String?
    var userId: Int?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
        userId <- map["userId"]
    }
}
*/

struct Post: HandyJSON {
    var id: Int?
    var title: String?
    var body: String?
    var userId: Int?
    
}

struct CommonResult: HandyJSON {
    var error: Bool?
    var results: [GankData]?
}

struct GankData: HandyJSON {
    var createdAt: Bool?
    var desc: String?
    var publishedAt: String?
    var source: String?
    var type: String?
    var url: String?
    var used: Bool?
    var who: String?
}


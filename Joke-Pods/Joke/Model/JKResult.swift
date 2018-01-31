//
//  JKResult.swift
//  Joke
//
//  Created by xiao on 2018/1/31.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import HandyJSON

class JKResult: HandyJSON {
    
    var count: Int = 0
    var err: Int = 0
    var page: Int = 0
    var refresh: Int = 0
    var total: Int = 0
    
    required init() {}
}



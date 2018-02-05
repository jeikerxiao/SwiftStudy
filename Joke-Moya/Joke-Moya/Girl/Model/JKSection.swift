//
//  JKSection.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import RxDataSources


struct JKSection {
    
    var items: [Item]
}

extension JKSection: SectionModelType {
    
    typealias Item = JKModel
    
    init(original: JKSection, items: [JKSection.Item]) {
        self = original
        self.items = items
    }
}

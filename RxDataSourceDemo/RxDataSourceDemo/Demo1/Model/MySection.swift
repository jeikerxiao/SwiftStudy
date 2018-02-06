//
//  MySection.swift
//  RxDataSourceDemo
//
//  Created by xiao on 2018/2/5.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import RxDataSources

struct MySection {
    var header: String
    var items: [Item]
}

extension MySection : AnimatableSectionModelType {
    typealias Item = Int
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

//
//  ModelType.swift
//  RxTodo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Then

protocol Identifiable {
    associatedtype Identifier: Equatable
    var id: Identifier { get }
}

protocol ModelType: Then {
    
}

extension Collection where Self.Iterator.Element: Identifiable {
    
    func index(of element: Self.Iterator.Element) -> Self.Index? {
        return self.index { $0.id == element.id }
    }
}

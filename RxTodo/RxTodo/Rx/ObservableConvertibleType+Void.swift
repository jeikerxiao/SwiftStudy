//
//  ObservableConvertibleType+Void.swift
//  RxTodo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import RxCocoa
import RxSwift

extension ObservableConvertibleType where E == Void {
    
    func asDriver() -> Driver<E> {
        return self.asDriver(onErrorJustReturn: Void())
    }
    
}

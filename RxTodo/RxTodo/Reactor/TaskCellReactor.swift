//
//  TaskCellReactor.swift
//  RxTodo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa

class TaskCellReactor: Reactor {
    
    typealias Action = NoAction
    
    let initialState: Task
    
    init(task: Task) {
        self.initialState = task
    }
}

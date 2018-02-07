//
//  EditViewReactor.swift
//  RxTodo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxDataSources
import RxSwift

enum TaskEditViewMode {
    case new
    case edit(Task)
}

enum TaskEditViewCancelAlertAction: AlertActionType {
    case leave
    case stay
    
    var title: String? {
        switch self {
        case .leave: return "Leave"
        case .stay: return "Stay"
        }
    }
    
    var style: UIAlertActionStyle {
        switch self {
        case .leave: return .destructive
        case .stay: return .default
        }
    }
}


final class EditViewReactor: Reactor {
    // 1.Action
    enum Action {
        // 更新任务标题
        case updateTaskTitle(String)
        // 取消
        case cancel
        // 提交
        case submit
    }
    // 2.Mutation
    enum Mutation {
        // 更新任务标题
        case updateTaskTitle(String)
        // 取消
        case dismiss
    }
    // 3.State
    struct State {
        var title: String
        var taskTitle: String
        var canSubmit: Bool
        var shouldConfirmCancel: Bool
        var isDismissed: Bool
        
        init(title: String, taskTitle: String, canSubmit: Bool) {
            self.title = title
            self.taskTitle = taskTitle
            self.canSubmit = canSubmit
            self.shouldConfirmCancel = false
            self.isDismissed = false
        }
    }
    
    let provider: ServiceProviderType
    let mode: TaskEditViewMode
    let initialState: State
    
    // 4.init State
    init(provider: ServiceProviderType, mode: TaskEditViewMode) {
        self.provider = provider
        self.mode = mode
        
        switch mode {
        case .new:
            self.initialState = State(title: "New", taskTitle: "", canSubmit: false)
        case .edit(let task):
            self.initialState = State(title: "Edit", taskTitle: task.title, canSubmit: true)
        }
    }
    // Action --> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateTaskTitle(taskTitle):
            return .just(.updateTaskTitle(taskTitle))
            
        case .submit:
            guard self.currentState.canSubmit else { return .empty() }
            switch self.mode {
            case .new:
                return self.provider.taskService
                    .create(title: self.currentState.taskTitle, memo: nil)
                    .map { _ in .dismiss }
                
            case .edit(let task):
                return self.provider.taskService
                    .update(taskID: task.id, title: self.currentState.taskTitle, memo: nil)
                    .map { _ in .dismiss }
            }
            
        case .cancel:
            if !self.currentState.shouldConfirmCancel {
                return .just(.dismiss) // no need to confirm
            }
            let alertActions: [TaskEditViewCancelAlertAction] = [.leave, .stay]
            return self.provider.alertService
                .show(
                    title: "Really?",
                    message: "All changes will be lost",
                    preferredStyle: .alert,
                    actions: alertActions
                )
                .flatMap { alertAction -> Observable<Mutation> in
                    switch alertAction {
                    case .leave:
                        return .just(.dismiss)
                        
                    case .stay:
                        return .empty()
                    }
            }
        }
    }
    // old State + Mutation -> new State
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        // 更新任务标题
        case let .updateTaskTitle(taskTitle):
            state.taskTitle = taskTitle
            state.canSubmit = !taskTitle.isEmpty
            state.shouldConfirmCancel = taskTitle != self.initialState.taskTitle
            return state
        // 取消
        case .dismiss:
            state.isDismissed = true
            return state
        }
    }
    
}

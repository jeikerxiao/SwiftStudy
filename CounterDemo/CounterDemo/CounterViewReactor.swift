//
//  CounterViewReactor.swift
//  CounterDemo
//
//  Created by xiao on 2018/2/6.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import ReactorKit
import RxSwift

final class CounterViewReactor: Reactor {
    // 1.Action
    enum Action {
        // 用户点击“+”
        case increase
        // 用户点击“-”
        case decrease
    }
    // 2.Mutation
    enum Mutation {
        // “+”值变化
        case increaseValue
        // "-"值变化
        case decreaseValue
        // 显示加载图标变化
        case setLoading(Bool)
    }
    // 3.Sate 当前视图的状态
    struct State {
        // 显示值
        var value: Int
        // 是否加载
        var isLoading: Bool
    }
    // 4.初始状态
    let initialState: State
    init() {
        self.initialState = State(
            value: 0,
            isLoading: false
        )
    }
    
    // 1. Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue)
                    .delay(0.5, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
                ])
            
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue)
                    .delay(0.5, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
                ])
        }
    }
    
    // 2. Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
        case .decreaseValue:
            state.value -= 1
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}

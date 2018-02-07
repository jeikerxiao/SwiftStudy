//
//  GitHubViewReactor.swift
//  GitHubDemo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

class GitHubViewReactor: Reactor {
    // 1.Action
    enum Action {
        case updateQuery(String?)
        case loadNextPage
    }
    // 2.Mutation
    enum Mutation {
        case setQuery(String?)
        case setRepos([String], nextPage: Int?)
        case appendRepos([String], nextPage: Int?)
        case setLoadingNextPage(Bool)
    }
    // 3.State
    struct State {
        var query: String?
        var repos: [String] = []
        var nextPage: Int?
        var isLoadingNextPage: Bool = false
    }
    // 4.init State
    let initialState = State()
    
    // 1. Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateQuery(query):
            return Observable.concat([
                // 1) set current state's query (.setQuery)
                Observable.just(Mutation.setQuery(query)),
                
                // 2) call API and set repos (.setRepos)
                GitHubService.search(query: query, page: 1)
                    // cancel previous request when the new `.updateQuery` action is fired
                    .takeUntil(self.action.filter(isUpdateQueryAction))
                    .map { Mutation.setRepos($0, nextPage: $1) },
                ])
            
        case .loadNextPage:
            guard !self.currentState.isLoadingNextPage else { return Observable.empty() } // prevent from multiple requests
            guard let page = self.currentState.nextPage else { return Observable.empty() }
            return Observable.concat([
                // 1) set loading status to true
                Observable.just(Mutation.setLoadingNextPage(true)),
                
                // 2) call API and append repos
                GitHubService.search(query: self.currentState.query, page: page)
                    .takeUntil(self.action.filter(isUpdateQueryAction))
                    .map { Mutation.appendRepos($0, nextPage: $1) },
                
                // 3) set loading status to false
                Observable.just(Mutation.setLoadingNextPage(false)),
                ])
        }
    }
    // 2. old State + Mutation -> new State
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setQuery(query):
            var newState = state
            newState.query = query
            return newState
            
        case let .setRepos(repos, nextPage):
            var newState = state
            newState.repos = repos
            newState.nextPage = nextPage
            return newState
            
        case let .appendRepos(repos, nextPage):
            var newState = state
            newState.repos.append(contentsOf: repos)
            newState.nextPage = nextPage
            return newState
            
        case let .setLoadingNextPage(isLoadingNextPage):
            var newState = state
            newState.isLoadingNextPage = isLoadingNextPage
            return newState
        }
    }
    
    private func isUpdateQueryAction(_ action: Action) -> Bool {
        if case .updateQuery = action {
            return true
        } else {
            return false
        }
    }
}

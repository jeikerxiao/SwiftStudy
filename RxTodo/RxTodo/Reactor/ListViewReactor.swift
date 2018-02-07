//
//  ListViewReactor.swift
//  RxTodo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import RxDataSources



typealias TaskListSection = SectionModel<Void, TaskCellReactor>

final class ListViewReactor: Reactor {
    // 1.Action
    enum Action {
        case refresh
        case toggleEditing
        case toggleTaskDone(IndexPath)
        case deleteTask(IndexPath)
        case moveTask(IndexPath, IndexPath)
    }
    // 2.Mutation
    enum Mutation {
        case toggleEditing
        case setSections([TaskListSection])
        case insertSectionItem(IndexPath, TaskListSection.Item)
        case updateSectionItem(IndexPath, TaskListSection.Item)
        case deleteSectionItem(IndexPath)
        case moveSectionItem(IndexPath, IndexPath)
    }
    // 3.State
    struct State {
        var isEditing: Bool
        var sections: [TaskListSection]
    }
    
    let provider: ServiceProviderType
    let initialState: State
    // 4.init State
    init(provider: ServiceProviderType) {
        self.provider = provider
        self.initialState = State(
            isEditing: false,
            sections: [TaskListSection(model: Void(), items: [])]
        )
    }
    // 1.Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return self.provider.taskService.fetchTasks()
                .map { tasks in
                    let sectionItems = tasks.map(TaskCellReactor.init)
                    let section = TaskListSection(model: Void(), items: sectionItems)
                    return .setSections([section])
            }
            
        case .toggleEditing:
            return .just(.toggleEditing)
            
        case let .toggleTaskDone(indexPath):
            let task = self.currentState.sections[indexPath].currentState
            if !task.isDone {
                return self.provider.taskService.markAsDone(taskID: task.id).flatMap { _ in Observable.empty() }
            } else {
                return self.provider.taskService.markAsUndone(taskID: task.id).flatMap { _ in Observable.empty() }
            }
            
        case let .deleteTask(indexPath):
            let task = self.currentState.sections[indexPath].currentState
            return self.provider.taskService.delete(taskID: task.id).flatMap { _ in Observable.empty() }
            
        case let .moveTask(sourceIndexPath, destinationIndexPath):
            let task = self.currentState.sections[sourceIndexPath].currentState
            return self.provider.taskService.move(taskID: task.id, to: destinationIndexPath.item)
                .flatMap { _ in Observable.empty() }
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let taskEventMutation = self.provider.taskService.event
            .flatMap { [weak self] taskEvent -> Observable<Mutation> in
                self?.mutate(taskEvent: taskEvent) ?? .empty()
        }
        return Observable.of(mutation, taskEventMutation).merge()
    }
    
    private func mutate(taskEvent: TaskEvent) -> Observable<Mutation> {
        let state = self.currentState
        switch taskEvent {
        case let .create(task):
            let indexPath = IndexPath(item: 0, section: 0)
            let reactor = TaskCellReactor(task: task)
            return .just(.insertSectionItem(indexPath, reactor))
            
        case let .update(task):
            guard let indexPath = self.indexPath(forTaskID: task.id, from: state) else { return .empty() }
            let reactor = TaskCellReactor(task: task)
            return .just(.updateSectionItem(indexPath, reactor))
            
        case let .delete(id):
            guard let indexPath = self.indexPath(forTaskID: id, from: state) else { return .empty() }
            return .just(.deleteSectionItem(indexPath))
            
        case let .move(id, index):
            guard let sourceIndexPath = self.indexPath(forTaskID: id, from: state) else { return .empty() }
            let destinationIndexPath = IndexPath(item: index, section: 0)
            return .just(.moveSectionItem(sourceIndexPath, destinationIndexPath))
            
        case let .markAsDone(id):
            guard let indexPath = self.indexPath(forTaskID: id, from: state) else { return .empty() }
            var task = state.sections[indexPath].currentState
            task.isDone = true
            let reactor = TaskCellReactor(task: task)
            return .just(.updateSectionItem(indexPath, reactor))
            
        case let .markAsUndone(id):
            guard let indexPath = self.indexPath(forTaskID: id, from: state) else { return .empty() }
            var task = state.sections[indexPath].currentState
            task.isDone = false
            let reactor = TaskCellReactor(task: task)
            return .just(.updateSectionItem(indexPath, reactor))
        }
    }
    // old State + Mutation -> new State
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setSections(sections):
            state.sections = sections
            return state
            
        case .toggleEditing:
            state.isEditing = !state.isEditing
            return state
            
        case let .insertSectionItem(indexPath, sectionItem):
            state.sections.insert(sectionItem, at: indexPath)
            return state
            
        case let .updateSectionItem(indexPath, sectionItem):
            state.sections[indexPath] = sectionItem
            return state
            
        case let .deleteSectionItem(indexPath):
            state.sections.remove(at: indexPath)
            return state
            
        case let .moveSectionItem(sourceIndexPath, destinationIndexPath):
            let sectionItem = state.sections.remove(at: sourceIndexPath)
            state.sections.insert(sectionItem, at: destinationIndexPath)
            return state
        }
    }
    
    private func indexPath(forTaskID taskID: String, from state: State) -> IndexPath? {
        let section = 0
        let item = state.sections[section].items.index { reactor in reactor.currentState.id == taskID }
        if let item = item {
            return IndexPath(item: item, section: section)
        } else {
            return nil
        }
    }
    
    func reactorForCreatingTask() -> EditViewReactor {
        return EditViewReactor(provider: self.provider, mode: .new)
    }

    func reactorForEditingTask(_ taskCellReactor: TaskCellReactor) -> EditViewReactor {
        let task = taskCellReactor.currentState
        return EditViewReactor(provider: self.provider, mode: .edit(task))
    }
    
}

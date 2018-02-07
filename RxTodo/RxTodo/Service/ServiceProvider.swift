//
//  ServiceProvider.swift
//  RxTodo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

protocol ServiceProviderType: class {
    var userDefaultsService: UserDefaultsServiceType { get }
    var alertService: AlertServiceType { get }
    var taskService: TaskServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var userDefaultsService: UserDefaultsServiceType = UserDefaultsService(provider: self)
    lazy var alertService: AlertServiceType = AlertService(provider: self)
    lazy var taskService: TaskServiceType = TaskService(provider: self)
}


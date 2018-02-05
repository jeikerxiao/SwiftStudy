//
//  JKViewModel.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

enum JKRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class JKViewModel: NSObject {
    // 存放着解析完成的模型数组
    let models = Variable<[JKModel]>([])
    // 记录当前的索引值
    var index: Int = 1
}

extension JKViewModel: JKViewModelType {
    
    typealias Input = JKInput
    typealias Output = JKOutput

    struct JKInput {
        // 网络请求类型
        let category: GankAPI.GankCategory
        
        init(category: GankAPI.GankCategory) {
            self.category = category
        }
    }

    struct JKOutput {
        // tableView的sections数据
        let sections: Driver<[JKSection]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        // 告诉外界的tableView当前的刷新状态
        let refreshStatus = Variable<JKRefreshStatus>(.none)
        
        init(sections: Driver<[JKSection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: JKViewModel.JKInput) -> JKViewModel.JKOutput {
        let sections = models.asObservable().map { (models) -> [JKSection] in
            // 当models的值被改变时会调用
            return [JKSection(items: models)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = JKOutput(sections: sections)
        
        output.requestCommond.subscribe(onNext: {[unowned self] isReloadData in
            self.index = isReloadData ? 1 : self.index+1
            gankApi.rx.request(.data(type: input.category, size: 10, index: Int64(self.index)))
//                .filterSuccessfulStatusCodes()
                .asObservable()
//                .mapJSON()
                .mapArray(JKModel.self)
                .subscribe({ [weak self] (event) in
                switch event {
                case let .next(modelArr):
                    self?.models.value = isReloadData ? modelArr : (self?.models.value ?? []) + modelArr
                    JKProgressHUD.showSuccess("加载成功")
                case let .error(error):
                    JKProgressHUD.showError(error.localizedDescription)
                case .completed:
                    output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
                }
                }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}



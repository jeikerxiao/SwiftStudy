//
//  PostViewModel.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import RxSwift
import Moya

typealias GankType = GankAPI.GankCategory

class PostViewModel {
    private let provider = MoyaProvider<CodeAPI>()
    
    func getPosts() -> Observable<[Post]> {
        return provider.rx.request(.list)
            .filterSuccessfulStatusCodes()
            .asObservable()
            .mapJSON()
            .mapArray(type: Post.self)
    }
    
    func createPost(title: String, body: String, userId: Int) -> Observable<Post> {
        return provider.rx.request(.create(title: title, body: body, userId: userId))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .mapJSON()
            .mapObject(type: Post.self)
    }
    
    func getAll() -> Observable<CommonResult> {
        return gankApi.rx.request(.data(type: GankType.mapCategory(with: 0), size: 20, index: 0))
            .filterSuccessfulStatusCodes()
            .asObservable()
            .mapJSON()
            .mapObject(type: CommonResult.self)
    }
}

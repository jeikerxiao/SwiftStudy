//
//  JKAboutViewModel.swift
//  Joke
//
//  Created by xiao on 2018/2/1.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class JKAboutViewModel: NSObject {

    func getUsers() -> Observable<[SectionModel<String, JKAboutModel>]> {
        return Observable.create { (observer) -> Disposable in
            let users = [JKAboutModel(followersCount: 19_901_990, followingCount: 1990, screenName: "Marco Sun "),
                         JKAboutModel(followersCount: 19_890_000, followingCount: 1989, screenName: "Taylor Swift "),
                         JKAboutModel(followersCount: 250_000, followingCount: 25, screenName: "Rihanna "),
                         JKAboutModel(followersCount: 13_000_000_000, followingCount: 13, screenName: "Jolin Tsai "),
                         JKAboutModel(followersCount: 25_000_000, followingCount: 25, screenName: "Adele ")]
            let section = [SectionModel(model: "", items: users)]
            observer.onNext(section)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

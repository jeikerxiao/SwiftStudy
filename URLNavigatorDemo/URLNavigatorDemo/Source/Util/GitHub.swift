//
//  GitHub.swift
//  URLNavigatorDemo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation

enum GitHub {
    static func repos(username: String, completion: @escaping (Result<[Repo]>) -> Void) {
        HTTP.request("/users/\(username)/repos?sort=updated") { result in
            result.map { data -> [Repo] in
                let repos = try? JSONDecoder().decode([Repo].self, from: data)
                return repos ?? []
                }
                .apply(completion)
        }
    }
}

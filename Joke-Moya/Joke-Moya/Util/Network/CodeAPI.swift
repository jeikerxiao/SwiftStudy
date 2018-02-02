//
//  CodeAPI.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import RxSwift
import Moya

enum CodeAPI {
    case list
    case create(title: String, body: String, userId: Int)
}

extension CodeAPI: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "http://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .list:
            return "/posts"
        case .create(_, _, _):
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .create(_, _, _):
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .list:
            return nil
        case .create(let title, let body, let userId):
            return ["title": title, "body": body, "userId": userId]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .list:
            return "[{\"userId\": \"1\", \"Title\": \"Title String\", \"Body\": \"Body String\"}]".data(using: String.Encoding.utf8)!
        case .create(_, _, _):
            return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        return .requestPlain
    }
}

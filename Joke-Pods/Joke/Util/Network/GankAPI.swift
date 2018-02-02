//
//  GankAPI.swift
//  Joke
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import Moya

enum GankAPI {
    
    enum GankCategory: String {
        
        case all      = "all"
        case android  = "Android"
        case ios      = "iOS"
        case video    = "休息视频"
        case welfare  = "福利"
        case resource = "拓展资源"
        case frontEnd = "前端"
        case mass     = "瞎推荐"
        case app      = "App"
        
        static func mapCategory(with hashValue: Int) -> GankCategory {
            switch hashValue {
            case 0:
                return .all
            case 1:
                return .android
            case 2:
                return .ios
            case 3:
                return .video
            case 4:
                return .welfare
            case 5:
                return .resource
            case 6:
                return .frontEnd
            case 7:
                return .mass
            case 8:
                return .app
            default:
                return .all
            }
        }
    }
    
    case data(type: GankCategory, size: Int64, index: Int64)
}

extension GankAPI: TargetType {
    
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    // 请求地址
    var baseURL: URL { return URL(string: "http://gank.io")! }
    
    var path: String {
        switch self {
        case .data(let type, let size, let index):
            return "/api/data/\(type.rawValue)/\(size)/\(index)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .data(_, _, _):
            return .get
//        default:
//            return .get
        }
    }
    // 测试数据
    var sampleData: Data {
        return "this is a sample data".utf8EncodedData
    }
    // 请求头
    public var headers: [String: String]? {
        return nil
    }
    // 请求参数
    var parameters: [String : Any]? {
        return nil
    }
    
    var task: Task {
        switch self {
        case .data(_, _, _):
            return .requestPlain
//        default:
//            return .requestPlain
        }
    }
    
    var validate: Bool {
        switch self {
        case .data(_, _, _):
            return false
//        default:
//            return false
        }
    }
}

let gankApi = MoyaProvider<GankAPI>()

// MARK: - Helpers

private extension String {
    
    var utf8EncodedData: Data {
        return self.data(using: .utf8)!
    }
}

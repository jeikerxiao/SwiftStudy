//
//  Observable+HandyJSON.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON
/*
// MARK: - Json -> Model
extension Response {
    // 将Json解析为单个Model
    public func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
        guard let jsonDict = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        return JSONDeserializer<T>.deserializeFrom(dict: jsonDict)!

    }
    
    // 将Json解析为多个Model，返回数组，对于不同的json格式需要对该方法进行修改
    public func mapArray<T: HandyJSON>(_ type: T.Type) throws -> [T] {
        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        guard let jsonDictArr = (json["results"] as? [[String : Any]]) else {
            throw MoyaError.jsonMapping(self)
        }
        return JSONDeserializer<T>.deserializeModelArrayFrom(array: jsonDictArr) as! [T]

    }
}
// MARK: - Json -> Observable<Model>
extension Observable {
    func mapObject<T: HandyJSON>(type: T.Type) -> Observable<T> {
        return self.map { response in
            // 如果返回为字典类型，则用HandyJSON 解析
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return JSONDeserializer<T>.deserializeFrom(dict: dict)!
        }
    }
    
    func mapArray<T: HandyJSON>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            // 如果返回为字典数组类型，则用HandyJSON 解析
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            return JSONDeserializer<T>.deserializeModelArrayFrom(array: dicts)! as! [T]
        }
    }
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }
*/

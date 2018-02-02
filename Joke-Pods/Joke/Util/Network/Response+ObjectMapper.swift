//
//  Response+ObjectMapper.swift
//  Joke
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import RxSwift
//import ObjectMapper

public extension Response {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
//    public func mapObject<T: BaseMappable>(_ type: T.Type) throws -> T {
//        guard let object = Mapper<T>().map(JSONObject: try mapJSON()) else {
//            throw MoyaError.jsonMapping(self)
//        }
//        return object
//    }
    public func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
        guard let jsonDictionary = try mapJSON() as? NSDictionary,
              let object = JSONDeserializer<T>.deserializeFrom(dict: jsonDictionary)
            else {
                throw MoyaError.jsonMapping(self)
        }
        return object
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
//    public func mapArray<T: BaseMappable>(_ type: T.Type) throws -> [T] {
//
//        guard let json = try mapJSON() as? [String: Any],
//            let result = json["results"] as? [[String : Any]]
//            else {
//                throw MoyaError.jsonMapping(self)
//        }
//        return Mapper<T>().mapArray(JSONArray: (result))
//    }
    public func mapArray<T: HandyJSON>(_ type: T.Type) throws -> [T] {
        
        guard let json = try mapJSON() as? [String: Any],
            let result = json["results"] as? [[String : Any]],
            let objArray = JSONDeserializer<T>.deserializeModelArrayFrom(array: result)
            else {
                throw MoyaError.jsonMapping(self)
        }
        if let objectArray: [T] = objArray as? [T] {
            return objectArray
        } else {
            throw MoyaError.jsonMapping(self)
        }
    }
    
}

// MARK: - ImmutableMappable

public extension Response {
    
    /// Maps data received from the signal into an object which implements the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
//    public func mapObject<T: ImmutableMappable>(_ type: T.Type) throws -> T {
//        return try Mapper<T>().map(JSONObject: try mapJSON())
//    }
    
    /// Maps data received from the signal into an array of objects which implement the ImmutableMappable
    /// protocol.
    /// If the conversion fails, the signal errors.
//    public func mapArray<T: ImmutableMappable>(_ type: T.Type) throws -> [T] {
//        guard let array = try mapJSON() as? [[String : Any]] else {
//            throw MoyaError.jsonMapping(self)
//        }
//        return try Mapper<T>().mapArray(JSONArray: array)
//    }
    
}


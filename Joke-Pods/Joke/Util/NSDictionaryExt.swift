//
//  NSDictionaryExt.swift
//  Joke
//
//  Created by xiao on 2018/1/27.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import UIKit

extension NSDictionary {
    func stringAttributeForKey(_ key:String) -> String {
        guard let obj = self[key] else {
            return ""
        }
        
        if let str = obj as? String {
            return str
        } else if let num = obj as? NSNumber {
            return num.stringValue
        } else {
            return ""
        }
    }
}

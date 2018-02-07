//
//  Task.swift
//  RxTodo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation

struct Task: ModelType, Identifiable {
    
    var id: String = UUID().uuidString
    var title: String
    var memo: String?
    var isDone: Bool = false
    
    init(title: String, memo: String? = nil) {
        self.title = title
        self.memo = memo
    }
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let title = dictionary["title"] as? String
            else {
                return nil
        }
        self.id = id
        self.title = title
        self.memo = dictionary["memo"] as? String
        self.isDone = dictionary["isDone"] as? Bool ?? false
    }
    
    func asDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": self.id,
            "title": self.title,
            "isDone": self.isDone
        ]
        if let memo = self.memo {
            dictionary["memo"] = memo
        }
        return dictionary
    }
    
}

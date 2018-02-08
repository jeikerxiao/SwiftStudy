//
//  Repo.swift
//  URLNavigatorDemo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

struct Repo: Decodable {
    var name: String
    var descriptionText: String?
    var starCount: Int
    var urlString: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case descriptionText = "description"
        case starCount = "stargazers_count"
        case urlString = "html_url"
    }
}

//
//  JKJokeTableViewController.swift
//  Joke
//
//  Created by xiao on 2018/1/26.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

enum JKJokeTableViewControllerType: Int {
    case hotJoke
    case newestJoke
    case imageTruth
}

class JKJokeTableViewController: UIViewController {
    
    let identifier = "JKJokeCellIdentifier"
    var jokeType:JKJokeTableViewControllerType = .hotJoke
    var tableView:UITableView?
    var dataArray = NSMutableArray()
    var cellHeight = NSMutableArray()
    var page:Int = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "列表"
    }
    
}

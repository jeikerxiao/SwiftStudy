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

class JKJokeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let identifier = "JKJokeCellIdentifier"
    var jokeType:JKJokeTableViewControllerType = .hotJoke
    var tableView:UITableView?
    var dataArray = NSMutableArray()
    var cellHeight = NSMutableArray()
    var page:Int = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "列表"
        
        setupViews()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // 设置视图
    func setupViews() {
        let width = UIScreen.main.bounds.size.width
        let height = self.view.frame.size.height
        self.tableView = UITableView(frame:CGRect(x:0, y:64, width:width, height:height-49-64))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        let nib = UINib(nibName:"JKJokeCell", bundle:nil)
        self.tableView?.register(nib, forCellReuseIdentifier: identifier)
        
        self.view.addSubview(self.tableView!)
    }
    
    // 加载数据
    func loadData() {
        let url = urlString()
        JKHttpUtil.requestWithURL(url, completionHandler: { data in
            if data as! NSObject == NSNull() {
                UIView.showAlertView("提示", message: "加载失败")
                return
            }
            
            let arr = data["items"] as! NSArray
            print(data)
            // 传入数据到 Cell
            for data in arr {
                self.cellHeight.add(JKJokeCell.cellHeightByData(data as! NSDictionary))
                self.dataArray.add(data)
            }
            // 重新加载数据
            self.tableView!.reloadData()
            self.page += 1;
        })
    }
    
    // 请求URL
    func urlString()->String {
        if jokeType == .hotJoke {
            // 最热糗事
            return "http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)"
        } else if jokeType == .newestJoke {
            // 最新糗事
            return "http://m2.qiushibaike.com/article/list/latest?count=20&page=\(page)"
        } else {
            // 有图有真相
            return "http://m2.qiushibaike.com/article/list/imgrank?count=20&page=\(page)"
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! JKJokeCell
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        cell.data = data
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        return self.cellHeight[index] as! CGFloat
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let index = indexPath.row
//        let data = self.dataArray[index] as! NSDictionary
//        let commentsVC = YRCommentsViewController(nibName :nil, bundle: nil)
//        commentsVC.jokeId = data.stringAttributeForKey("id")
//        self.navigationController!.pushViewController(commentsVC, animated: true)
    }
    // 刷新视图
//    func refreshView(_ refreshView:JKRefreshView,didClickButton btn:UIButton) {
//        loadData()
//    }
}

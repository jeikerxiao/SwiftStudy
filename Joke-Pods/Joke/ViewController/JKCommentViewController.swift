//
//  JKCommentViewController.swift
//  Joke
//
//  Created by xiao on 2018/1/29.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

class JKCommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,JKRefreshViewDelegate{

    let identifier = "cell"
    var jokeType:JKJokeTableViewControllerType = .hotJoke
    var tableView:UITableView?
    var dataArray = NSMutableArray()
    var page :Int = 1
    var refreshView:JKRefreshView?
    var jokeId:String!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "评论"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置视图
        setupViews()
        // 加载数据
        loadData()
    }
    
    func setupViews() {
        let width = UIScreen.main.bounds.size.width
        let height = self.view.frame.size.height
        self.tableView = UITableView(frame:CGRect(x: 0,y: 0,width: width,height: height))
        self.tableView!.delegate = self;
        self.tableView!.dataSource = self;
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.none
//        let nib = UINib(nibName:"JKCommentCell", bundle: nil)
        let nib = R.nib.jkCommentCell()
        self.tableView?.register(nib, forCellReuseIdentifier: identifier)
        
        var arr =  Bundle.main.loadNibNamed("JKRefreshView" ,owner: self, options: nil)!
        self.refreshView = arr[0] as? JKRefreshView
        self.refreshView!.delegate = self
        
        self.tableView!.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView!)
    }
    
    func loadData() {
        let url = "http://m2.qiushibaike.com/article/\(self.jokeId!)/comments?count=20&page=\(self.page)"
        self.refreshView!.startLoading()
        JKHttpUtil.request(url,completionHandler:{ data in
            
            if data as! NSObject == NSNull() {
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            print("评论：\(data)")
            let arr = data["items"] as! NSArray
            if arr.count  == 0 {
                UIView.showAlertView("提示",message:"暂无新评论哦")
                self.tableView!.tableFooterView = nil
            }
            for data in arr {
                self.dataArray.add(data)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page += 1
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? JKCommentCell
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        cell!.data  = data
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        return  JKCommentCell.cellHeightByData(data)
    }

    // 刷新视图
    func refreshView(_ refreshView:JKRefreshView,didClickButton btn:UIButton) {
        loadData()
    }
}

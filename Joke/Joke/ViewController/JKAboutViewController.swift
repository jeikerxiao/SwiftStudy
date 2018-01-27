//
//  JKAboutViewController.swift
//  Joke
//
//  Created by xiao on 2018/1/26.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

class JKAboutViewController: UIViewController {
    
    @IBAction func followMe() {
        let urlStr = "https://weibo.com/1251313652"
        let url = URL(string: urlStr)
        UIApplication.shared.openURL(url!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "关于"
    }
 
}

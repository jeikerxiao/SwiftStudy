//
//  JKRefreshView.swift
//  Joke
//
//  Created by xiao on 2018/1/28.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

protocol JKRefreshViewDelegate {
    func refreshView(_ refreshView:JKRefreshView, didClickButton btn:UIButton)
}

class JKRefreshView: UIView {

    @IBOutlet var button:UIButton!
    @IBOutlet var indicator:UIActivityIndicatorView!
    @IBAction func buttonClicked(_ sender:UIButton) {
        self.delegate.refreshView(self, didClickButton:sender)
    }
    
    var delegate: JKRefreshViewDelegate!
    // 初始化显示
    override func awakeFromNib() {
        super.awakeFromNib()
        self.indicator!.isHidden = true
    }
    // 开始加载
    func startLoading() {
        self.button!.setTitle("", for: UIControlState())
        self.indicator!.isHidden = false
        self.indicator!.startAnimating()
    }
    // 停止加载
    func stopLoadin() {
        self.button!.setTitle("点击加载更多", for: UIControlState())
        self.indicator!.isHidden = true
        self.indicator!.stopAnimating()
    }
}

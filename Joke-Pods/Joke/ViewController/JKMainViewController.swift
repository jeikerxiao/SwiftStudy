//
//  JKMainViewController.swift
//  Joke
//
//  Created by xiao on 2018/1/26.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

/**
 * 主视图
 */
class JKMainViewController: UITabBarController {
    
    var myTabbar:UIView?
    var slider:UIView?
    // 按钮背景色
    let btnBGColor:UIColor = UIColor(red:125/255.0, green:236/255.0,blue:198/255.0,alpha: 1)
    // tabBar 背景色
    let tabBarBGColor:UIColor = UIColor(red:251/255.0, green:173/255.0,blue:69/255.0,alpha: 1)
    // 标题颜色
    let titleColor:UIColor = UIColor(red:52/255.0, green:156/255.0,blue:150/255.0,alpha: 1)
    // 标题名
    let itemArray = ["最新", "热门", "真相", "关于"]
    
    // 初始化设置
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "最新"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        initViewControllers()
    }
    
    func setupViews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        self.tabBar.isHidden = true
        
        let width = UIScreen.main.bounds.size.width
        let height = self.view.frame.size.height
        
        self.myTabbar  = UIView(frame:CGRect(x:0, y:height-49, width:width, height:49))
        self.myTabbar!.backgroundColor = tabBarBGColor
        self.slider = UIView(frame:CGRect(x:0, y:0, width:80, height:49))
        self.slider!.backgroundColor = UIColor.white
        self.myTabbar!.addSubview(self.slider!)
        
        self.view.addSubview(self.myTabbar!)
        
        let count = self.itemArray.count
        // 设置 tabBar 的标题
        for index in 0 ..< count {
            let btnWidth = (CGFloat)(width/4)
            let button = UIButton(type: UIButtonType.custom)
            let x = (btnWidth*(CGFloat)(index))
            button.frame = CGRect(x:x, y:0, width:btnWidth, height:49)
            button.tag = index+100
            
            let title = self.itemArray[index]
            button.setTitle(title, for: UIControlState())
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.setTitleColor(tabBarBGColor, for: UIControlState.selected)
            // 添加按键点击事件
            button.addTarget(self, action: #selector(JKMainViewController.tabBarButtonClicked(_:)), for: UIControlEvents.touchUpInside)
            // 添加到视图上
            self.myTabbar?.addSubview(button)
            if index == 0 {
                button.isSelected = true
            }
        }
    }
    
    // 初始化视图控制器
    func initViewControllers() {
        let vc1 = JKJokeTableViewController()
        vc1.jokeType = .newestJoke
        let vc2 = JKJokeTableViewController()
        vc2.jokeType = .hotJoke
        let vc3 = JKJokeTableViewController()
        vc3.jokeType = .imageTruth
//        let vc4 = JKAboutViewController(nibName: "JKAboutViewController", bundle: nil)
        let vc4 = JKAboutViewController(nib: R.nib.jkAboutViewController)

        // 添加四个视图到当前主视图
        self.viewControllers = [vc1, vc2, vc3, vc4]
    }
    
    // 按钮点击事件
    @objc func tabBarButtonClicked(_ sender:UIButton) {
        let index = sender.tag
        // 选择按钮的选择状态
        for i in 0 ..< 4 {
            let button = self.view.viewWithTag(100+i) as! UIButton
            if button.tag == index {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        let width = UIScreen.main.bounds.size.width;
        let btnWidth = (CGFloat)(width/4)
        // 增加按钮动画效果
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.slider!.frame = CGRect(x: CGFloat(index-100)*btnWidth,y: 0,width: btnWidth,height: 49)
                        })
        self.title = itemArray[index-100] as String
        self.selectedIndex = index-100
    }
}

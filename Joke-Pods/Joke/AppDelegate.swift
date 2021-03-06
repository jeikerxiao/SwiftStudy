//
//  AppDelegate.swift
//  Joke
//
//  Created by xiao on 2018/1/26.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import XCGLogger

// 日志框架（定义全局变量）
let log = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 设置日志
        setupLog()
        // 设置窗体
//        setupMian()
        setupAbout()
        
        return true
    }
    
    func setupLog() {
        log.setup(level: .debug,
                  showLogIdentifier: false,
                  showFunctionName: false,
                  showThreadName: false,
                  showLevel: true,
                  showFileNames: true,
                  showLineNumbers: true,
                  showDate: true,
                  writeToFile: nil,
                  fileLevel: nil)
        
        log.verbose("日志启动成功！")
        log.debug("日志启动成功！")
        log.info("日志启动成功！")
        log.warning("日志启动成功！")
        log.error("日志启动成功！")
        log.severe("日志启动成功！")
    }
    
    func setupMian() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // 初始化主视图
        let mainViewController = JKMainViewController(nibName:nil, bundle:nil)
        // 初始化导航视图
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        // 指定根控制器为导航视图
        self.window!.rootViewController = navigationViewController;
        // 显示
        self.window!.makeKeyAndVisible()
    }
    
    func setupAbout() {
        let nav = UINavigationController(rootViewController: JKAboutTableViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


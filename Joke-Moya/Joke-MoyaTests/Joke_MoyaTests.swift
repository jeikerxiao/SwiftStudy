//
//  Joke_MoyaTests.swift
//  Joke-MoyaTests
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import XCTest
@testable import Joke_Moya

class Joke_MoyaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAPI() {
        gankApi.rx.request(.data(type: GankAPI.GankCategory.all, size: 10, index: 0))
                            .filterSuccessfulStatusCodes()
            .asObservable()
//                            .mapJSON()
            .mapArray(JKModel.self)
            .subscribe({ [weak self] (event) in
                switch event {
                case let .next(modelArr):
                    JKProgressHUD.showSuccess("加载成功")
                case let .error(error):
                    JKProgressHUD.showError(error.localizedDescription)
                case .completed:
                    JKProgressHUD.showSuccess("加载成功")
                }
            }).disposed(by: self.rx.disposeBag)
    }
    
}

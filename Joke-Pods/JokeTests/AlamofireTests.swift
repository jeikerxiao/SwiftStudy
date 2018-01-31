//
//  AlamofireTests.swift
//  JokeTests
//
//  Created by xiao on 2018/1/30.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import XCTest
import Alamofire

class AlamofireTests: XCTestCase {
    
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
    
    func testGet() {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            
            print("request: \(response.request)")      // 原始的URL请求
            print("response: \(response.response)")    // HTTP URL响应
            print("data: \(response.data)")            // 服务器返回的数据
            print("result: \(response.result)")        // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    func testPost() {
        Alamofire.request("https://httpbin.org/post", method: .post).responseJSON { response in
            
            print("request: \(response.request)")      // 原始的URL请求
            print("response: \(response.response)")    // HTTP URL响应
            print("data: \(response.data)")            // 服务器返回的数据
            print("result: \(response.result)")        // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    func testPut() {
        Alamofire.request("https://httpbin.org/put", method: .put).responseJSON { response in
            print("request: \(response.request)")      // 原始的URL请求
            print("response: \(response.response)")    // HTTP URL响应
            print("data: \(response.data)")            // 服务器返回的数据
            print("result: \(response.result)")        // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }

    }
    
    func testDelete() {
        Alamofire.request("https://httpbin.org/delete", method: .delete).responseJSON { response in
            print("request: \(response.request)")      // 原始的URL请求
            print("response: \(response.response)")    // HTTP URL响应
            print("data: \(response.data)")            // 服务器返回的数据
            print("result: \(response.result)")        // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}

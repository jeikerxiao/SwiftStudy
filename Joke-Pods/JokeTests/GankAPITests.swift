//
//  GankAPITests.swift
//  JokeTests
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import XCTest
@testable import Joke
import RxSwift
import RxCocoa
import NSObject_Rx
import Moya

typealias GankType = GankAPI.GankCategory

class GankAPITests: XCTestCase {
    
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
//        let provider = MoyaProvider<GankAPI>()
//        provider.request(.data(type: GankType.mapCategory(with: 1), size: 20, index: 0)) { result in
//            print(result)
//            print(result)
//        }
        gankApi.request(.data(type: GankType.mapCategory(with: 1), size: 20, index: 0)) { result in
            print(result)
        }
    }
    
    func testRxAPI() {
//        let provider = RxMoyaProvider<GankAPI>()
        gankApi.request(.data(type: GankType.mapCategory(with: 1), size: 20, index: 0))
            .filterSuccessfulStatusCodes()
            .subscribe(onNext: {
                print($0)
            })
            .addDisposableTo(rx.disposeBag)
    }
//
//    func testApiJson() {
//        let provider = MoyaProvider<GankAPI>()
//
//        provider.request(.data(type: GankType.mapCategory(with: $0), size: 20, index: 0))
//            .mapJSON()
//            .subscribe(onNext: { json in
//                print(json)
//            })
//            .addDisposableTo(rx.disposeBag)
//    }
    
}

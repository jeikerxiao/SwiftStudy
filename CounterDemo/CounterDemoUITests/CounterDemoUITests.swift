//
//  CounterDemoUITests.swift
//  CounterDemoUITests
//
//  Created by xiao on 2018/2/6.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import XCTest
@testable import CounterDemo


import ReactorKit
import RxSwift


class CounterDemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    /*
    func testAction_refresh() {
        // 1. prepare a stub reactor
        let reactor = CounterViewReactor()
        reactor.stub.isEnabled = true
        
        // 2. prepare a view with a stub reactor
        let view = CounterViewController()
        view.reactor = reactor
        
        // 3. send an user interaction programatically
        view.increaseButton.sendActions(for: .valueChanged)
        
        // 4. assert actions
        XCTAssertEqual(reactor.stub.actions.last, .increase)
    }
    */
    /*
    func testState_isLoading() {
        // 1. prepare a stub reactor
        let reactor = CounterViewReactor()
        reactor.stub.isEnabled = true
        
        // 2. prepare a view with a stub reactor
        let view = CounterViewController()
        view.reactor = reactor
        
        // 3. set a stub state
        reactor.stub.state.value = CounterViewReactor.State(value: 0, isLoading: true)
        
        // 4. assert view properties
        XCTAssertEqual(view.activityIndicatorView.isAnimating, true)
    }
*/
    
}

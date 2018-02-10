//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by xiao on 2018/2/8.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testRx()
//        anonymousObservable()
//        testError()
        testDeferred()
    }

    // 把一系列元素转换为事件序列
    func testRx() {
        let sequenceOfElements = Observable.of(1,2,3,4)
        
        _ = sequenceOfElements.subscribe{ event in
            print(event)
        }
    }
    /*
    AnonymousObservable继承自Producer，Producer实现了线程调度功能，
    可以安排线程来执行run方法，因此AnonymousObservable是可以运行在指定线程中Observable。
    */
    func anonymousObservable() {

        let generated = Observable.generate(
            initialState: 0,
            condition: {$0<20},
            iterate: {$0+4}
        )

        _ = generated.subscribe{
            print($0)
        }
    }
    // Error，顾名思义，是做错误处理的，创建一个不发送任何 item 的 Observable。
    func testError() {
        let error = NSError(domain: "Test", code:-1, userInfo: nil)

        let erroredSequence = Observable<Any>.error(error)
        _ = erroredSequence.subscribe{
            print($0)
        }
    }

    /*
    deferred会等到有订阅者的时候再通过工厂方法创建Observable对象，
    每个订阅者订阅的对象都是内容相同而完全独立的序列。
    */
    func testDeferred() {
        let deferredSequence: Observable<Int> = Observable.deferred {
            print("creating")
            return Observable.create { observer in
                print("emmiting")
                observer.onNext(0)
                observer.onNext(1)
                observer.onNext(2)
                return Disposables.create()
            }
        }

        _ = deferredSequence.subscribe { event in
            print(event)
        }

        _ = deferredSequence.subscribe { event in
            print(event)
        }
    }
    // empty创建一个空的序列。它仅仅发送.Completed消息
    func testEmpty() {
        let emptySequence = Observable<Int>.empty()
        
        _ = emptySequence.subscribe{ event in
            print(event)
        }
    }
    // never创建一个序列，该序列永远不会发送消息，.Complete消息也不会发送
    func testNever() {
        let neverSequence = Observable<Int>.never()
        
        _ = neverSequence.subscribe{ _ in
            print("这句话不会被打印")
        }
    }
    //just代表只包含一个元素的序列。它将向订阅者发送两个消息，第一个消息是其中元素的值，另一个是.Completed。
    func testJust() {
        let singleElementSequence = Observable.just("iOS")
        
        _ = singleElementSequence.subscribe{
            print($0)
        }
    }
    
    func testPublish() {
        let subject = PublishSubject<Int>()
        
        _ = subject.subscribe {
            print($0)
        }
        
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.onNext(4)
    }
    
    func testReplay() {
        let subject = ReplaySubject<Int>.create(bufferSize: 2)
        
        _ = subject1.subscribe{ event in
            print("1->\(event)")
        }
        
        subject.onNext(1)
        subject.onNext(2)
        
        _ = subject.subscribe { event in
            print("2->\(event)")
        }
        
        subject.onNext(3)
        subject.onNext(4)
    }
    
    func testBehavior() {
        let subject = BehaviorSubject(value: "z")
        
        _ = subject.subscribe { event in
            print("1->\(event)")
        }
        
        subject.onNext("a")
        subject.onNext("b")
        
        _ = subject.subscribe { event in
            print("2->\(event)")
        }
        
        subject.onNext("c")
        subject.onCompleted()
    }

    func testVariable() {
        let variable = Varible("z")

        _ = variable.asObservable().subscribe{ event in
            print("1->\(event)")
        }

        variable.value = "a"
        variable.value = "b"

        _ = variable.asObservable().subscribe { event in
            print("2->\(event)")
        }

        variable.value = "c"
    }

}


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
//        testDeferred()
//        testFlatMap()
        testDistinctUntilChanged()
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
        
        _ = subject.subscribe{ event in
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
        let variable = Variable("z")

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
    // map就是对每个元素都用函数做一次转换，挨个映射一遍。
    func testMap() {
        let originalSequence = Observable.of(1,2,3)

        _ = originalSequence.map{ number in
            number * 2
        }
        .subscribe{
            print($0)
        }
    }
    // flatMap将每个Observable发射的数据变换为Observable的集合，然后将其降维排列成一个Observable
    func testFlatMap() {
        let sequenceInt = Observable.of(1,2,3)

        let sequenceString = Observable.of("A", "B", "C", "D", "E", "F", "iOS")

        _ = sequenceInt.flatMap { (event: Int) -> Observable<String> in
            print("From sequentInt \(event)")
            return sequenceString
         }
        .subscribe{
            print($0)
        }
    }
    // scan对Observable发射的每一项数据应用一个函数，然后按顺序依次发射一个值。
    func testScan() {
        let sequenceToSum = Observable.of(1, 2, 3, 4, 5)

        _ = sequenceToSum.scan(0) { acum, elem in
            acum + elem
        }
        .subscribe{
            print($0)
        }
    }
    // filter只会让符合条件的元素通过
    func testFilter() {
        let subscription = Observable.of(0,1,2,3,4,5,6,7,8,9)

        _ = subscription.filter{
            $0 % 2 == 0
        }
        .subscribe{
            print($0)
        }
    }
    //distinctUntilChanged会废弃掉重复的事件
    func testDistinctUntilChanged() {
        _ = Observable.of(1,1,1,1,1,1,1,1,1,2,2,2,3,3,4,4,5,5,5,6,6,6,7,7,7)
                    .distinctUntilChanged()
                    .subscribe{
                        print($0)
                    }
    }
    // take只获取序列中的前n个事件，在满足数量之后会自动.Completed。
    func testTake() {
        _ = Observable.of(1,5,6,7,3,6,7,9,23,21)
                    .take(4)
                    .subscribe {
                        print($0)
                    }
    }
    // startWith会在队列开始之前插入一个事件元素
    func testStartWith() {
        _ = Observable.of(1,2,3)
                    .startWith(0)
                    .subscribe{
                        print($0)
                    }
    }
    // CombineLatest如果存在两件事件队列，需要同时监听，那么每当有新的事件发生的时候，
    // combineLatest会将每个队列的最新一个元素进行合并。
    func testCombineLastest() {
        let observer1 = PublishSubject<String>()
        let observer2 = PublishSubject<Int>()
        _ = Observable.combineLatest(observer1, observer2){
            "\($0)\($1)"
        }
        .subscribe {
            print($0)
        }

        observer1.onNext("iOS")
        observer2.onNext(6)
        observer1.onNext("Swift")
        observer2.onNext(66)
        observer1.onNext("Rx")
        observer2.onNext(666)
    }

    func testCombineLastest2() {
        let observer1 = Observable.just(2)
        let observer2 = Observable.of(0,1,2,3,4)
        _ = Observable.combineLatest(observer1, observer2) {
            $0 * $1
        }
        .subscribe{
            print($0)
        }
    }

    func testCombineLastest3() {
        let observer1 = Observable.just(2)
        let observer2 = Observable.of(0,1,2,3)
        let observer3 = Observable.of(0,1,2,3,4)
        _ = Observable.combineLatest(observer1, observer2, observer3) {
            ($0 + $1) * $2
        }
        .subscribe{
            print($0)
        }
    }
    // zip合并两条队列，不过它会等到两个队列的元素一一对应地凑齐之后再合并
    func testZip() {
        let stringObserver = PublishSubject<String>()
        let intObserver = PublishSubject<Int>()

        _ = Observable.zip(stringObserver, intObserver){
            "\($0) \($1)"
        }.subscribe{
            print($0)
        }

        stringObserver.onNext("iOS")
        intObserver.onNext(6)
        stringObserver.onNext("swift")
        intObserver.onNext(66)
        stringObserver.onNext("Rx")
        intObserver.onNext(666)
        stringObserver.onNext("不会打印")
    }
    // merge合并多个Observables的组合成一个
    func testMerge() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()

        _ = Observable.of(subject1,subject2)
                .merge()
                .subscribe{ event in
                    print(event)
                }
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext(1)
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext(2)
    }
    // switchLatest将一个发射多个Observables的Observable转换成另一个单独的Observable，
    // 后者发射那些Observables最近发射的数据项
    func testSwitchLatest() {
        let var1 = Variable(0)
        let var2 = Variable(200)
        let var3 = Variable(var1.asObservable())
        _ = var3.asObservable()
                .switchLatest()
                .subscribe{
                    print($0)
                }

        var1.value = 1
        var1.value = 2
        var1.value = 3
        var1.value = 4
        var3.value = var2.asObservable()
        var2.value = 201
        var1.value = 5
        var1.value = 6
        var1.value = 7

    }
    // catchError收到error通知之后，转而发送一个没有错误的序列
    func testCatchError() {
        let sequenceThatFails = PublishSubject<Int>()
        let recoverySequence = Observable.of(100,200,300,400)
        _ = sequenceThatFails
                .catchError{ error in
                    return recoverySequence
                }.subscribe{
                    print($0)
                }

        sequenceThatFails.onNext(1)
        sequenceThatFails.onNext(2)
        sequenceThatFails.onNext(3)
        sequenceThatFails.onNext(4)
        sequenceThatFails.onError(NSError(domain: "Test", code: 0, userInfo: nil))
    }

}


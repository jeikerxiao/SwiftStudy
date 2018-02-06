//
//  CounterViewController.swift
//  CounterDemo
//
//  Created by xiao on 2018/2/6.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class CounterViewController: UIViewController, StoryboardView {
    
    
    @IBOutlet var decreaseButton: UIButton!
    @IBOutlet var increaseButton: UIButton!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "计数器"
    }
    
    func bind(reactor: CounterViewReactor) {
        
        // View --(Action)--> Reactor
        increaseButton.rx.tap                   // Tap event
            .map { Reactor.Action.increase }    // Convert to Action.increase
            .bind(to: reactor.action)           // Bind to reactor.action
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Reactor --(State)--> View
        reactor.state
            .map{ $0.value }
            .distinctUntilChanged()
            .map{ "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map{ $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }

}

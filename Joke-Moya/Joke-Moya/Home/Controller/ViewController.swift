//
//  ViewController.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let viewModel = PostViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
    }
    
    func setupViewModel() {
        
        viewModel.getPosts()
            .subscribe(onNext: { (posts: [Post]) in
                //do something with posts
                print(posts.count)
                print(posts[1].title!)
            })
            .disposed(by: disposeBag)
        
        viewModel.createPost(title: "Title 1", body: "Body 1", userId: 1)
            .subscribe(onNext: { (post: Post) in
                //do something with post
//                print(post.title!)
            })
            .disposed(by: disposeBag)
        
        viewModel.getAll()
            .subscribe(onNext: { (commonResult: CommonResult) in
                //do something with posts
                print(commonResult.error ?? "")
                print(commonResult.results ?? "")

            })
            .disposed(by: disposeBag)
    }

}


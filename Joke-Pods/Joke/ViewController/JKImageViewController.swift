//
//  JKImageViewController.swift
//  Joke
//
//  Created by xiao on 2018/1/28.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import Kingfisher

class JKImageViewController: UIViewController {
    
    var imageURL:String = ""
    var imageZoomingView:JKImageZoomingView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = "图片"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    func setupViews() {
        self.imageZoomingView = JKImageZoomingView(frame:self.view.frame)
        self.imageZoomingView.imageURL = self.imageURL
        self.view.addSubview(self.imageZoomingView)
    }
}

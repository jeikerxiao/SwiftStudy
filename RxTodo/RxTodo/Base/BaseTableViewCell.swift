//
//  BaseTableViewCell.swift
//  RxTodo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var disposeBag: DisposeBag = DisposeBag()

    // MARK: Initializing
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        
    }
}

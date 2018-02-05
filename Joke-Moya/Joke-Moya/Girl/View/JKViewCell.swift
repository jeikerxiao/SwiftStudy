//
//  JKViewCell.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import Reusable

class JKViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension JKViewCell {
    static func cellHeigh() -> CGFloat {
        return 240
    }
}

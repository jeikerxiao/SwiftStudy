//
//  JKColorCell.swift
//  RxDataSourceDemo
//
//  Created by xiao on 2018/2/5.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import Reusable

class JKColorCell: UITableViewCell, Reusable {
    
    private lazy var colorView: UIView = {
        let colorView = UIView()
        colorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        colorView.frame = self.contentView.bounds.insetBy(dx: 50, dy: 5)
        self.contentView.addSubview(colorView)
        return colorView
    }()
    
    func fill(_ color: UIColor) {
        self.colorView.backgroundColor = color
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

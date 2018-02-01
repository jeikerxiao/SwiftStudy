//
//  JKAboutCell.swift
//  Joke
//
//  Created by xiao on 2018/2/1.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

class JKAboutCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var user: JKAboutModel? {
        willSet {
            let string = "\(newValue!.screenName)在简书上关注了\(newValue!.followingCount)个用户，并且被\(newValue!.followersCount)个用户关注了。"
            backgroundColor = tag % 2 == 0 ? UIColor.lightGray : UIColor.white
            textLabel?.text = string
            textLabel?.numberOfLines = 0
        }
    }

}

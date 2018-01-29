//
//  JKCommentCell.swift
//  Joke
//
//  Created by xiao on 2018/1/29.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

class JKCommentCell: UITableViewCell {
    
    @IBOutlet var avatarView:UIImageView?
    @IBOutlet var nickLabel:UILabel?
    @IBOutlet var contentLabel:UILabel?
    @IBOutlet var floorLabel:UILabel?
    @IBOutlet var dateLabel:UILabel?
    
    var data:NSDictionary!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard ((self.data) != nil) else{
            return;
        }
        
        let user = self.data["user"]
        
        if user as! NSObject != NSNull() {
            let userDict = user as! NSDictionary
            self.nickLabel!.text = userDict["login"] as! NSString as String
            // 头像
            let icon = userDict["icon"]
            if icon as! NSObject != NSNull() {
                let userIcon = icon as! String
                let userId = userDict.stringAttributeForKey("id") as NSString
                let prefixUserId = userId.substring(to: 3)
                let userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userId)/thumb/\(userIcon)"
                self.avatarView!.setImage(userImageURL, placeHolder: UIImage(named: "avatar.jpg"))
            } else {
                self.avatarView!.image = UIImage(named: "avatar.jpg")
            }
            // 日期
            let timeStamp = userDict.stringAttributeForKey("created_at")
            let date = timeStamp.dateStringFromTimestamp(timeStamp as NSString)
            self.dateLabel!.text = date
        } else {
            // 默认显示
            self.nickLabel!.text = "匿名"
            self.avatarView!.image =  UIImage(named: "avatar.jpg")
            self.dateLabel!.text = ""
        }
        // 显示评论内容
        let content = self.data.stringAttributeForKey("content")
        let width = UIScreen.main.bounds.size.height
        let height = content.stringHeightWith(17,width:width-10*2)
        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        // 显示楼层
        self.dateLabel!.setY(self.contentLabel!.bottom())
        let floor = self.data.stringAttributeForKey("floor")
        self.floorLabel!.text = "\(floor)楼"
    }
    // 自动计算高度
    class func cellHeightByData(_ data:NSDictionary)->CGFloat {
        let content = data.stringAttributeForKey("content")
        let width = UIScreen.main.bounds.size.height
        let height = content.stringHeightWith(17,width:width-10*2)
        return 53.0 + height + 24.0
    }
}

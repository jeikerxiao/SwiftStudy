//
//  JKJokeCell.swift
//  Joke
//
//  Created by xiao on 2018/1/26.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

class JKJokeCell: UITableViewCell {
    
    @IBOutlet var nickLabel:UILabel?
    @IBOutlet var avatarView:UIImageView?
    @IBOutlet var contentLabel:UILabel?
    @IBOutlet var pictureView:UIImageView?
    
    @IBOutlet var bottomView:UIView?
    @IBOutlet var commentLabel:UILabel?
    @IBOutlet var likeLabel:UILabel?
    @IBOutlet var dislikeLabel:UILabel?
    
    var largeImageURL:String = ""
    var data:NSDictionary!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard ((self.data) != nil) else {
            return;
        }
        
        let user = self.data["user"]
        
        if let userDictOp:NSDictionary = user as? NSDictionary {
            let userDict = userDictOp
            // 昵称
            self.nickLabel!.text = userDict["login"] as! String?
            // 头像
            let icon = userDict["icon"]
            if icon as! NSObject != NSNull() {
                let userIcon = icon as! String
                if let idNumber = userDict["id"] as? NSNumber {
                    let userId = idNumber.stringValue as NSString
                    let prefixUserId = userId.substring(to: userId.length - 4)
                    let userImageURL = "http://pic.qiushibaike.com/system/avtnew/\(prefixUserId)/\(userId)/medium/\(userIcon)"
                    self.avatarView!.setImage(userImageURL, placeHolder: UIImage(named: "avatar.jpg"))
                }
            } else {
                self.nickLabel!.text = "匿名"
                self.avatarView!.image = UIImage(named:"avatar.jpg")
            }
            // 内容
            let content = self.data.stringAttributeForKey("content")
            let width = UIScreen.main.bounds.size.width
            let height = content.stringHeightWith(17, width: width-10*2)
            self.contentLabel!.setHeight(height)
            self.contentLabel!.text = content
            // 内容图片
            let imgSrc = self.data.stringAttributeForKey("image") as NSString
            if imgSrc.length == 0 {
                self.pictureView!.isHidden = true
                self.bottomView!.setY(self.contentLabel!.bottom())
            } else {
                let imageId = self.data.stringAttributeForKey("id") as NSString
                let prefiximageId = imageId.substring(to: imageId.length - 4)
                let imagURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageId)/\(imageId)/small/\(imgSrc)"
                self.pictureView!.isHidden = false
                self.pictureView!.setImage(imagURL,placeHolder: UIImage(named: "avatar.jpg"))
                self.largeImageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageId)/\(imageId)/medium/\(imgSrc)"
                self.pictureView!.setY(self.contentLabel!.bottom()+5)
                self.bottomView!.setY(self.pictureView!.bottom())
            }
            // 显示顶和踩
            if let votesDict = self.data["votes"] as? NSDictionary {
                let like  = votesDict.stringAttributeForKey("up")
                let disLike  = votesDict.stringAttributeForKey("down")
                self.likeLabel!.text = "顶(\(like))"
                self.dislikeLabel!.text = "踩(\(disLike))"
            } else {
                self.likeLabel!.text = "顶(0)"
                self.dislikeLabel!.text = "踩(0)"
                // self.likeLabel!.text = "评论(0)"
            }
            // 显示评论数
            let commentCount = self.data.stringAttributeForKey("comments_count")
            self.commentLabel!.text = "评论(\(commentCount))"
            
        }
        
    }
    
    class func cellHeightByData(_ data:NSDictionary)->CGFloat {
        let width = UIScreen.main.bounds.size.width;
        let content = data.stringAttributeForKey("content")
        let height = content.stringHeightWith(17,width:width-10*2)
        let imgSrc = data.stringAttributeForKey("image")
        if imgSrc.isEmpty {
            return 59.0 + height + 40.0
        }
        return 59.0 + height + 5.0 + 112.0 + 40.0
    }
    
    
}

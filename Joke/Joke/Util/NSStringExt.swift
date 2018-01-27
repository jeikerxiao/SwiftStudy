//
//  NSStringExt.swift
//  Joke
//
//  Created by xiao on 2018/1/27.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // 计算字符串高度
    func stringHeightWith(_ fontSize:CGFloat,width:CGFloat)->CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = CGSize(width: width,height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping;
        let  attributes = [NSAttributedStringKey.font:font,
                           NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]
        
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
    func dateStringFromTimestamp(_ timeStamp:NSString)->String {
        let ts = timeStamp.doubleValue
        let  formatter = DateFormatter ()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
        let date = Date(timeIntervalSince1970 : ts)
        return  formatter.string(from: date)
    }
}

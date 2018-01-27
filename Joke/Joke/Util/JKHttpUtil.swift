//
//  JKHttpUtil.swift
//  Joke
//
//  Created by xiao on 2018/1/27.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import Foundation
import UIKit

class JKHttpUtil: NSObject {
    
    override init() {
        super.init();
    }
    
    class func requestWithURL(_ urlString:String,completionHandler:@escaping (_ data:AnyObject)->Void)
    {
        let URL = Foundation.URL(string: urlString);
        let req = URLRequest(url: URL!)
        let queue = OperationQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if (error != nil) {
                DispatchQueue.main.async(execute: {
                    print(error!)
                    completionHandler(NSNull())
                })
            } else {
                let jsonData = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                
                DispatchQueue.main.async(execute: {
                    completionHandler(jsonData)
                    
                })
            }
        })
    }
}

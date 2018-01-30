//
//  UIImageViewWebExt.swift
//  Joke
//
//  Created by xiao on 2018/1/27.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import Foundation


extension UIImageView {
    
    func setImage(_ urlString:String, placeHolder:UIImage!) {
        
        let url = URL(string: urlString)
        let cacheFilename = url!.lastPathComponent
        let cachePath = FileUtil.cachePath(cacheFilename)
        let image : AnyObject = FileUtil.imageDataFromPath(cachePath)
        
        if image as! NSObject != NSNull() {
            self.image = image as? UIImage
        } else {
            let req = URLRequest(url: url!)
            let queue = OperationQueue();
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
                if (error != nil) {
                    DispatchQueue.main.async(execute: {
                        print(error!)
                        self.image = placeHolder
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        let image = UIImage(data: data!)
                        if (image == nil) {
                            print("image is nil and url fail=\(urlString)")
                            self.image = placeHolder
                        } else {
                            self.image = image
                            let bIsSuccess = FileUtil.imageCacheToPath(cachePath,image:data!)
                            if !bIsSuccess {
                                print("*******cache fail,path=\(cachePath)")
                            }
                        }
                    })
                }
            })
        }
    }
}

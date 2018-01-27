//
//  FileUtil.swift
//  Joke
//
//  Created by xiao on 2018/1/27.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit

class FileUtil: NSObject {
    class func cachePath(_ fileName:String) -> String {
        var arr = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let path = arr[0]
        return "\(path)/\(fileName)"
    }
    
    class func imageCacheToPath(_ path:String, image:Data)->Bool {
        return ((try? image.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil)
    }
    
    class func imageDataFromPath(_ path:String)->AnyObject {
        let exist = FileManager.default.fileExists(atPath: path)
        if exist {
            _ = try? Data(contentsOf: URL(fileURLWithPath: path))
            
            let img = UIImage(contentsOfFile: path)
            let url:URL? = URL(fileURLWithPath: path)
            let dd = FileManager.default.contents(atPath: url!.path)
            _ = UIImage(data:dd!)
            
            if img != nil {
                return img!
            } else {
                return NSNull()
            }
        }
        return NSNull()
    }
}

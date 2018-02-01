//
//  JKAboutViewController.swift
//  Joke
//
//  Created by xiao on 2018/1/26.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class JKAboutViewController: UIViewController {
    
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!

    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    var disposeBag = DisposeBag()
    
    @IBAction func followMe() {
        let urlStr = "https://weibo.com/1251313652"
        let url = URL(string: urlStr)
        UIApplication.shared.openURL(url!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "关于"
        
        testView()
        autoGeneratePassword()
    }
 
    func testView() {
        
        Observable.combineLatest(number1.rx.text.orEmpty,
                                 number2.rx.text.orEmpty,
                                 number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                                    return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
    }
    
    func autoGeneratePassword() {
        _ = usernameTF.rx.text.orEmpty.asObservable()
            .distinctUntilChanged()
            .map{
                if  $0.count == 11 {
                    return $0.substring(from: $0.index($0.startIndex, offsetBy: 5))
                }else {
                    return ""
                }
            }
            .bind(to: passwordTF.rx.text)
            .disposed(by: disposeBag)
    }
    
}

//
//  ViewController.swift
//  RxDataSourceDemo
//
//  Created by xiao on 2018/2/5.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<MySection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(cellType: JKColorCell.self)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            configureCell: { ds, tv, ip, item in
                let colorCell = self.tableView.dequeueReusableCell(for: ip) as JKColorCell
                let red: CGFloat = ip.row == 0 ? 1.0 : 0.0
                colorCell.fill(UIColor(red: red, green: 0.0, blue: 1-red, alpha: 1.0))
                return colorCell
                /*
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "Item \(item)"
                return cell
                */
        },
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
        }
        )
        
        self.dataSource = dataSource
        // 设置模型数据
        let sections = [
            MySection(header: "First section", items: [
                1,
                2
                ]),
            MySection(header: "Second section", items: [
                3,
                4
                ])
        ]
        // 绑定数据源
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        // 设置代理
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}



extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // you can also fetch item
        guard let item = dataSource?[indexPath],
            // .. or section and customize what you like
            let _ = dataSource?[indexPath.section]
            else {
                return 0.0
        }
        
        return CGFloat(40 + item * 10)
    }
}



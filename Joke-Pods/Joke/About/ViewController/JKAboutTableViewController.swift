//
//  JKAboutTableViewController.swift
//  Joke
//
//  Created by xiao on 2018/2/1.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class JKAboutTableViewController: UIViewController {
    
    let tableView: UITableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    let reuseIdentifier = "\(JKAboutCell.self)"

    let viewModel = JKAboutViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置视图
        setupView()
    }
    
    func setupView() {
        self.title = "列表"
        view.addSubview(tableView)
        tableView.register(JKAboutCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, JKAboutModel>>(configureCell: {
            _, tableView, indexPath, user in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! JKAboutCell
            cell.tag = indexPath.row
            cell.user = user
            return cell
        })
        
        viewModel.getUsers()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

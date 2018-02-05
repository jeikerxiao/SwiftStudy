//
//  JKGirlViewController.swift
//  Joke-Moya
//
//  Created by xiao on 2018/2/2.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import Then
import SnapKit
import Moya
import Kingfisher
import MJRefresh

class JKGirlViewController: UIViewController {

    let viewModel = JKViewModel()
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.red
        $0.register(cellType: JKViewCell.self)
        $0.rowHeight = JKViewCell.cellHeigh()
    }
    var dataSource: RxTableViewSectionedReloadDataSource<JKSection>?
    var vmOutput : JKViewModel.JKOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindView()
        
        // 加载数据
        tableView.mj_header.beginRefreshing()
    }
}

extension JKGirlViewController {
    
    fileprivate func setupUI() {
        self.title = "列表"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(20);
        }
    }
    
    fileprivate func bindView() {
        // 绑定cell
        let dataSource = RxTableViewSectionedReloadDataSource<JKSection>(configureCell: { ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as JKViewCell
            cell.picView.kf.setImage(with: URL(string: item.url))
            cell.descLabel.text = "描述: \(String(describing: item.desc))"
            cell.sourceLabel.text = "来源: \(String(describing: item.source))"
            return cell
        }
        )
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        
        let vmInput = JKViewModel.JKInput(category: .welfare)
        let vmOutput = viewModel.transform(input: vmInput)
        
        vmOutput.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        vmOutput.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: rx.disposeBag)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            vmOutput.requestCommond.onNext(true)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            vmOutput.requestCommond.onNext(false)
        })
    }
}

extension JKGirlViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

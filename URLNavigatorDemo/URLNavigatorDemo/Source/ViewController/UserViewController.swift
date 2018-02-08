//
//  UserViewController.swift
//  URLNavigatorDemo
//
//  Created by xiao on 2018/2/7.
//  Copyright © 2018年 jeikerxiao. All rights reserved.
//

import UIKit
import URLNavigator

class UserViewController: UIViewController {
    
    // MARK: Properties
    
    private let navigator: NavigatorType
    let username: String
    var repos = [Repo]()
    
    // MARK: UI
    
    let tableView = UITableView()
    
    // MARK: Initializing
    
    init(navigator: NavigatorType, username: String) {
        self.navigator = navigator
        self.username = username
        print("[Navigator] UserViewController: \(username)")
        super.init(nibName: nil, bundle: nil)
        self.title = "\(username)'s Repositories"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加到当前视图上
        self.view.addSubview(self.tableView)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(RepoCell.self, forCellReuseIdentifier: "repo")
        // 请求网络数据
        GitHub.repos(username: self.username) { [weak self] result in
            guard let `self` = self else { return }
            self.repos = (result.value ?? []).sorted { $0.starCount > $1.starCount }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            self.navigationItem.leftBarButtonItem = nil
        } else if self.presentationController != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(doneButtonDidTap)
            )
        }
    }
    
    // MARK: Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
    
    // MARK: Actions
    
    @objc func doneButtonDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource 数据源

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repo", for: indexPath) as! RepoCell
        let repo = self.repos[indexPath.row]
        cell.textLabel?.text = repo.name
        cell.detailTextLabel?.text = repo.descriptionText
        cell.detailTextLabel?.textColor = .gray
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UITableViewDelegate 代理

extension UserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let repo = self.repos[indexPath.row]
        let webViewController = self.navigator.present(repo.urlString, wrap: nil)
        webViewController?.title = "\(self.username)/\(repo.name)"
        print("[Navigator] push: \(repo.urlString)")
    }
}

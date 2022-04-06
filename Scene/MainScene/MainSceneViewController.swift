//
//  MainSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/06.
//

import Foundation
import SnapKit
import UIKit

class MainSceneViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}

extension MainSceneViewController {
    func setupNavigationBar() {
        navigationItem.title = "Deep Forest"
        
        //UIBarButtonItem.SystemItem
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

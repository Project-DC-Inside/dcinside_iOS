//
//  MenuSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/07.
//

import Foundation
import SnapKit
import UIKit

class MenuSceneViewController: UIViewController {
    private lazy var presenter = MenuScenePresenter(viewController: self)
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.dataSource = presenter
        tv.delegate = presenter
        return tv
    }()
    private lazy var settingButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "gear")
        
        return button
    }()
    
    private lazy var signInButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "applelogo")
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension MenuSceneViewController: MenuSceneProtocol {
    func setUpNavigationBar() {
        navigationItem.title = "로그인 하실래요?"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [settingButton, signInButton]
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
                
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func signInSetUp(signInID: String) {
        // To-Do : 받아온 ID 데이터 토대로 해서 로그인 못하게 화면 구성해야함
    }
}

extension MenuSceneViewController {
    
}


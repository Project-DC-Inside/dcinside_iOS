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
        button.target = self
        button.action = #selector(settingButtonTapped)
        return button
    }()
    
    private lazy var signInButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.image = UIImage(systemName: "lock")
        
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
        
        signInButton.action = #selector(signInButtonTapped)
    }
    
    func presentSignInScene() {
        let signInViewController = SignInSceneViewController()
        signInViewController.view.backgroundColor = .systemBackground
        navigationItem.backButtonTitle = ""
        
        self.navigationController?.pushViewController(signInViewController, animated: true)
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
        navigationItem.title = "\(signInID)님!"
        signInButton.action = #selector(signOutButtonTapped)
        signInButton.image = UIImage(systemName: "lock.fill")
    }
    
    func signOutAction() {
        navigationItem.title = "로그인 하실래요?"
        signInButton.action = #selector(signInButtonTapped)
    }
}

extension MenuSceneViewController {
    @objc func settingButtonTapped() {
        // To-Do: 세팅 버튼 누르면 무슨일이 벌어질까?!
        print("Setting")
    }
    
    @objc func signInButtonTapped() {
        // To-Do: 사인 업 버튼 누르면?!
        presenter.didTapSignInButton()
    }
    
    @objc func signOutButtonTapped() {
        // To-Do: 로그아웃하면?..
        presenter.didTapSignOutButton()
    }
}


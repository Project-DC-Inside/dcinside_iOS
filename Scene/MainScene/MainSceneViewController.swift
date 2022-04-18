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
    private lazy var presenter = MainScenePresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.dataSource = presenter
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.reloadTableView()
    }
}

extension MainSceneViewController: MainSceneViewProtocol {
    func setupNavigationBar() {
        navigationItem.title = "Deep Forest"
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(didTapLeftButton))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func presentToMenuSelectSceneViewController() {
        let viewController = MenuSceneViewController()
        navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension MainSceneViewController {
    @objc func didTapLeftButton() {
        presenter.didTapLeftButton()
    }
}

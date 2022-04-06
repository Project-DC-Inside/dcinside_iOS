//
//  MainScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/06.
//

import Foundation
import UIKit

protocol MainSceneProtocol {
    func setupNavigationBar()
    func setUpViews()
    func presentToMenuSelectSceneViewController()
    func reloadTableView()
}


class MainScenePresenter: NSObject {
    private let viewController: MainSceneProtocol
    //private var popularPosts: [PopularPost] = []
    
    init(viewController: MainSceneProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setUpViews()
    }
    
    func didTapLeftButton() {
        viewController.presentToMenuSelectSceneViewController()
    }
    
    func reloadTableView() {
        viewController.reloadTableView()
    }
}

extension MainScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

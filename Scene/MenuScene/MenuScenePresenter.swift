//
//  MenuScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/07.
//

import Foundation
import UIKit

protocol MenuSceneProtocol: AnyObject {
    func setUpNavigationBar()
    func setUpViews()
    func signInSetUp(signInID: String)
}

class MenuScenePresenter: NSObject {
    private weak var viewController: MenuSceneProtocol?
    private let tableViewItems: [String] = ["메이저 갤러리", "마이너 갤러리", " 미니 갤러리"]
    
    init(viewController: MenuSceneProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setUpNavigationBar()
        viewController?.setUpViews()
    }
    
    func viewWillAppear() {
        guard let signInID = UserDefaults.standard.string(forKey: "singInID") else { return }
        
        viewController?.signInSetUp(signInID: signInID)
    }
}

extension MenuScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tableViewItems[indexPath.row]
        
        return cell
    }
    
    
}

extension MenuScenePresenter: UITableViewDelegate {
    
}

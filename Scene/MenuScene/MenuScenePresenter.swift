//
//  MenuScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/07.
//

import Foundation
import UIKit

enum GalleryType: String {
    case major = "major"
    case minor = "minor"
    case mini = "mini"
}

protocol MenuSceneProtocol: AnyObject {
    func setUpNavigationBar()
    func setUpViews()
    func signInSetUp(signInID: String)
    func presentSignInScene()
    func signOutAction()
    func presentGalleryList(galleryType: String)
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
        guard let signInID = UserDefaults.standard.string(forKey: "signInID") else { return }
        
        viewController?.signInSetUp(signInID: signInID)
    }
    
    func didTapSignInButton() {
        viewController?.presentSignInScene()
    }
    
    func didTapSignOutButton() {
        // Todo: 삭제해야할건 UserDefaults랑 키체인 정보!
        UserDefaults.standard.removeObject(forKey: "signInID")
        viewController?.signOutAction()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var type: String?
        switch indexPath.row {
        case 0:
            type = GalleryType.major.rawValue
        case 1:
            type = GalleryType.minor.rawValue
        default:
            type = GalleryType.mini.rawValue
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        guard let type = type else { return }
        viewController?.presentGalleryList(galleryType: type)
    }
}

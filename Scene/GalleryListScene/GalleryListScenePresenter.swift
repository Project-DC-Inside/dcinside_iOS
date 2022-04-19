//
//  GalleryListScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation
import UIKit

protocol GalleryListSceneProtocol: AnyObject {
    func setViews()
}

class GalleryListScenePresenter: NSObject {
    private weak var viewController: GalleryListSceneProtocol?
    
    init(viewController: GalleryListSceneProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setViews()
    }
}

extension GalleryListScenePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension GalleryListScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "LIST TEST"
        return cell
    }
    
    
}

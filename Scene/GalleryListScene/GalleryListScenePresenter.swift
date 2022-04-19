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
    func eraseThisScene()
    func reLoadData()
}

class GalleryListScenePresenter: NSObject {
    private weak var viewController: GalleryListSceneProtocol?
    private var galleryList: [Gallery] = []
    
    init(viewController: GalleryListSceneProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setViews()
    }
    
    func viewWillAppear(galleryType: String) {
        print("VIEWWILLAPPEAR", galleryType)
        APIService.shared.fetchGalleryList(galleryType: galleryType) { [weak self] response in
            switch response {
            case .success(let galleryList):
                self?.galleryList = galleryList
                self?.viewController?.reLoadData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func didTappedBackButton() {
        viewController?.eraseThisScene()
    }
}

extension GalleryListScenePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension GalleryListScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = galleryList[indexPath.row].name
        return cell
    }
    
    
}
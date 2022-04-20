//
//  GalleryPostListScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation
import UIKit

protocol GalleryPostListSceneProtocol: AnyObject {
    func setViews()
    func reloadData()
}

class GalleryPostListScenePresenter: NSObject {
    private weak var viewController: GalleryPostListSceneProtocol?
    private var postList: [PostInfo] = []
    var postListLastID = 0
    
    init(viewController: GalleryPostListSceneProtocol) {
        self.viewController = viewController
        self.postListLastID = 0
    }
    
    func viewDidLoad() {
        viewController?.setViews()
    }
    
    func viewWillAppear(galleryID: Int) {
        APIService.shared.fetchPostList(postListRequest: PostListRequest(galleryId: galleryID, lastPostId: postListLastID)) {
            [weak self] res in
            
            switch res {
            case .success(let data):
                self?.postList = data
                self?.postListLastID += 1
                self?.viewController?.reloadData()
            case .failure(let e):
                print(e)
            }
        }
        viewController?.reloadData()
    }
}

extension GalleryPostListScenePresenter: UITableViewDelegate {
    
}

extension GalleryPostListScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = postList[indexPath.row].title
        
        return cell
    }
}

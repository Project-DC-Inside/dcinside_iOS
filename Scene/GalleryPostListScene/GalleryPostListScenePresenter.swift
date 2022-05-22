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
    func moveMakePostScene()
    func movePostScene(postInfo: PostInfo)
}

class GalleryPostListScenePresenter: NSObject {
    private weak var viewController: GalleryPostListSceneProtocol?
    private var postList: [PostInfo] = []
    var postListLastID: Int? = nil
    var fetchingMore: Bool = false
    var galleryid: Int = -1
    
    init(viewController: GalleryPostListSceneProtocol) {
        self.viewController = viewController
        self.postListLastID = 0
    }
    
    func viewDidLoad(galleryID: Int) {
        viewController?.setViews()
        
        galleryid = galleryID
        APIService.shared.fetchPostList(postListRequest: PostListRequest(galleryId: galleryID, lastPostId: nil)) {
            [weak self] res in
            
            switch res {
            case .success(let data):
                if data.count == 0 {
                    return
                }
                self?.postList = data
                self?.postListLastID = data.last!.id
                self?.viewController?.reloadData()
            case .failure(let e):
                print(e)
            }
        }
    }
    
    func viewWillAppear(galleryID: Int) {
        
    }
    
    func didTappedAddPostButton() {
        viewController?.moveMakePostScene()
    }
    
    func refreshTableView() {
        viewController?.reloadData()
    }
}

extension GalleryPostListScenePresenter: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewController?.movePostScene(postInfo: postList[indexPath.row])
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                fetchingMore = true
                APIService.shared.fetchPostList(postListRequest: PostListRequest(galleryId: galleryid, lastPostId: postListLastID)) { [weak self] response in
                    switch response {
                    case .success(let data):
                        if data.count == 0 {
                            return
                        }
                        self?.postList += data
                        self?.postListLastID = data.last!.id
                        self?.viewController?.reloadData()
                        self?.fetchingMore = false
                    case .failure(let e):
                        print(e)
                    }
                }
            }
        }
    }
        
}

extension GalleryPostListScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryPostListCell") as! GalleryPostListCell
        cell.setLabels(cellInfo: postList[indexPath.row])
        
        return cell
    }
}

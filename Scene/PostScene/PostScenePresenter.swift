//
//  PostScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/28.
//

import Foundation
import UIKit

protocol PostSceneProtocol: AnyObject {
    func viewConfigure()
    func updatePost(postInfo: PostInfo)
    func reloadData()
}

class PostScenePresenter: NSObject {
    private weak var viewController: PostSceneProtocol?
    private let postId: Int
    private var postInfo: PostInfo? = nil
    
    init(viewController: PostSceneProtocol?, postId: Int) {
        self.viewController = viewController
        self.postId = postId
    }
    
    func viewDidLoad() {
        viewController?.viewConfigure()
        
        APIService.shared.fetchPostInfo(postId: postId) { [weak self] result in
            switch result {
            case .success(let postInfo):
                self?.postInfo = postInfo
                self?.viewController?.updatePost(postInfo: postInfo)
                self?.viewController?.reloadData()
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func viewWillAppear() {
        viewController?.reloadData()
    }
}

extension PostScenePresenter: UITableViewDelegate {
    
}

extension PostScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let test = "TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST "
        guard let postInfo = postInfo else { return UITableViewCell() }
        switch row {
        case 0:
            let cell = TitleLabelCell()
            cell.textLabel?.text = postInfo.title
            cell.textLabel?.font = .systemFont(ofSize: 28)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = WriterLabelCell()
            cell.textLabel?.text = postInfo.writer.nickname
            cell.textLabel?.font = .systemFont(ofSize: 18)
            cell.textLabel?.textColor = .systemGray
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = PostSubInformCell()
            cell.textLabel?.text = "조회: \(postInfo.postStatistics.viewCount) 댓글: \(postInfo.postStatistics.commentCount) \(postInfo.createdAt)"
            cell.textLabel?.font = .systemFont(ofSize: 13)
            cell.textLabel?.textColor = .systemGray
            cell.selectionStyle = .none
            return cell
        default:
            let cell = ContentCell(content: (postInfo.content ?? "") + test)
            cell.selectionStyle = .none
            return cell
            break
        }
    }
    
    
}

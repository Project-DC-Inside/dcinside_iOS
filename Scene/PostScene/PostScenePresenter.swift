//
//  PostScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/28.
//

import Foundation
import UIKit

enum EditPostError: Error {
    case notMatchInfo
    case exceededAuthority
}

extension EditPostError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notMatchInfo:
            return "정보가 맞지 않습니다."
        case .exceededAuthority:
            return "권한 밖의 일입니다."
        }
    }
}

protocol PostSceneProtocol: AnyObject {
    func viewConfigure()
    func updatePost(postInfo: PostInfo)
    func reloadData()
    func modifyPost(presenter: ModifyPostScenePresenter?)
    func checkUnSignedPassword(postId: Int)
    func presentError(error: Error)
}

class PostScenePresenter: NSObject {
    private weak var viewController: PostSceneProtocol?
    private let postId: Int
    private var postInfo: PostInfo? = nil
    private var modifyPresenter: ModifyPostScenePresenter? = nil
    
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
    
    func modifySignedState(id: String) {
        guard let postInfo = postInfo, let postId = postInfo.writer.username else { return }
        if postId.lowercased() != id.lowercased() {
            viewController?.presentError(error: EditPostError.notMatchInfo)
            return
        }
        modifyPresenter = ModifyPostScenePresenter(postInfo: postInfo, signState: .signed)
        viewController?.modifyPost(presenter: modifyPresenter)
    }
    
    func modifyUnSignedState() {
        guard let postInfo = postInfo else {
            return
        }
        print("ModifyUnSignedState")
        viewController?.checkUnSignedPassword(postId: postInfo.id)
    }
    
    func presentUnsignedModify() {
        guard let postInfo = postInfo else { return }
        
        modifyPresenter = ModifyPostScenePresenter(postInfo: postInfo, signState: .unsigned)
        viewController?.modifyPost(presenter: modifyPresenter)
    }
    
    func checkPassword(text: String?, postId: Int) {
        guard let text = text else { return }
        APIService.shared.checkNonMemberPassword(unsignedPostPasswordChecker: UnsignedPostPasswordChecker(postId: postId, password: text)) { [weak self] result in
            switch result {
            case .success(let _):
                self?.presentUnsignedModify()
            case .failure(let error):
                self?.viewController?.presentError(error: error)
                
            }
        }
    }
    
    func tapModifyButton() {
        if let id = UserDefaults.standard.string(forKey: "signInID") {
            modifySignedState(id: id)
        }
        modifyUnSignedState()
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
            let cell = ContentCell(content: (postInfo.content ?? ""))
            cell.selectionStyle = .none
            return cell
            break
        }
    }
    
    
}

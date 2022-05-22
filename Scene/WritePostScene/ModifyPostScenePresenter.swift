//
//  ModifyPostScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/22.
//

import Foundation
import UIKit

enum SignState {
    case signed
    case unsigned
}

protocol ModifyPostSceneProtocol: AnyObject {
    func setLayout()
    func setAlert(message: String)
}

class ModifyPostScenePresenter: NSObject {
    private weak var viewController: ModifyPostSceneProtocol? = nil
    private let postInfo: PostInfo
    private let signState: SignState
    
    private let title = TitleTextFieldPresenter()
    private let contentTextPresenter = ContentTextPresenter()
    
    private let placeHolders: [String] = ["제목을 입력하세요", "닉네임을 입력하세요", "비밀번호를 입력하세요"]
    
    init(postInfo: PostInfo, signState: SignState) {
        self.postInfo = postInfo
        self.signState = signState
    }
    
    func setViewController(viewController: ModifyPostSceneProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setLayout()
    }
    
    func submitSignedState(modifyingContent: ModifyingSignedEntity) {
        APIService.shared.submitModifyPostLogIn(postNumber: postInfo.id, post: modifyingContent) { [weak self] result in
            switch result {
            case .success(let _):
                self?.viewController?.setAlert(message: "성공!")
            case .failure(let error):
                self?.viewController?.setAlert(message: error.localizedDescription)
            }
        }
    }
    
    func submitUnSignedState(modifyingContent: ModifyingUnSignedEntity) {
        
        APIService.shared.submitModifyPostLogOff(postNumber: postInfo.id, post: modifyingContent) { [weak self] result in
            switch result {
            case .success(let _):
                self?.viewController?.setAlert(message: "성공!")
            case .failure(let error):
                self?.viewController?.setAlert(message: error.localizedDescription)
            }
            
        }
    }
    
    func didTappedSubmitButton() {
        guard let title = title.getTitle() else { return }
        let content = contentTextPresenter.getContent()
        switch signState {
        case .signed:
            let modifyingContent = ModifyingSignedEntity(title: title, content: content)
            submitSignedState(modifyingContent: modifyingContent)
        case .unsigned:
            let modifyingContent = ModifyingUnSignedEntity(title: title, content: content)
            submitUnSignedState(modifyingContent: modifyingContent)
        }
    }
}

extension ModifyPostScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = TitleTextFieldCell()
            cell.viewDidLoad(presenter: title)
            title.setViewController(viewController: cell)
            title.setText(text: postInfo.title)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = ContentTextViewCell()
            cell.viewDidLoad(presenter: contentTextPresenter)
            contentTextPresenter.setViewController(viewController: cell)
            cell.selectionStyle = .none
            guard let text = postInfo.content else { return cell }
            contentTextPresenter.setTextView(text: text)
            return cell
        }
    }
    
    
}

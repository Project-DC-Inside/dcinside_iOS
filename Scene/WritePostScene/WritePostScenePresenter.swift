//
//  WritePostScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation
import UIKit

protocol WritePostSceneProtocol: AnyObject {
    func setViewLayout()
    func setViewsAttribute()
    func postSuccess()
    func postFailed(_ error: String)
}

class WritePostScenePresenter: NSObject {
    private weak var viewController: WritePostSceneProtocol?
    private let isLogin: Bool
    
    private let title = TitleTextFieldPresenter()
    private let nickname = TitleTextFieldPresenter()
    private let password = TitleTextFieldPresenter()
    
    private lazy var textfield = [self.title, self.nickname, self.password]
    private var contentTextPresenter = ContentTextPresenter()
    
    private let placeHolders: [String] = ["제목을 입력하세요", "닉네임을 입력하세요", "비밀번호를 입력하세요"]
    
    init(viewController: WritePostSceneProtocol) {
        self.viewController = viewController
        if UserDefaults.standard.string(forKey: "signInID") == nil {
            isLogin = false
        } else {
            isLogin = true
        }
    }
    
    func viewDidLoad() {
        viewController?.setViewsAttribute()
        viewController?.setViewLayout()
    }
    
    func didTappedSubmitButton(galleryId: Int) {
        let title = title.getTitle()
        let nickname = nickname.getTitle()
        let password = password.getTitle()
        let content = contentTextPresenter.getContent()
        print(content)
        if isLogin {
            submitInLogin(post: PostSubmitLogIn(galleryId: galleryId, title: title!, content: content))
        } else {
            submitInLogOff(post: PostSubmitLogOff(galleryId: galleryId, title: title!, nickname: nickname!, password: password!, content: content))
        }
        
    }
                         
    func submitInLogOff(post: PostSubmitLogOff) {
        APIService.shared.submitPostLogOff(post: post) {  response in
            print(response)
            switch response {
            case .success:
                DispatchQueue.main.async {
                    [weak self] in
                    self?.viewController?.postSuccess()
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async { [weak self] in
                    self?.viewController?.postFailed(error.localizedDescription)
                }
            }
        }
    }
   
    func submitInLogin(post: PostSubmitLogIn) {
        APIService.shared.submitPostLogIn(post: post) {  response in
            print(response)
            switch response {
            case .success:
                DispatchQueue.main.async {
                    [weak self] in
                    self?.viewController?.postSuccess()
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async { [weak self] in
                    self?.viewController?.postFailed(error.localizedDescription)
                }
            }
        }
    }
}

extension WritePostScenePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLogin ? 2: 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let range = 0..<(isLogin ? 1: 3)
        let row = indexPath.row
        switch row {
        case range:
            let cell = TitleTextFieldCell()
            let presenter = textfield[row]
            cell.viewDidLoad(presenter: presenter)
            presenter.setViewController(viewController: cell)
            presenter.setPlaceHolder(placeholder: placeHolders[indexPath.row])
            print(placeHolders[indexPath.row], "ROW")
            if indexPath.row == 2 {
                presenter.setSecretText()
            }
            cell.selectionStyle = .none
            return cell
        default:
            let cell = ContentTextViewCell()
            cell.viewDidLoad(presenter: contentTextPresenter)
            contentTextPresenter.setViewController(viewController: cell)
            cell.selectionStyle = .none
            print("CELL")
            return cell
        }
        
    }
    
    
}

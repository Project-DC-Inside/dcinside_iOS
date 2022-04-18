//
//  SignInPresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/17.
//

import Foundation
import UIKit

protocol SignInSceneProtocol: AnyObject {
    func setUpViews()
    func popScene()
}

class SignInPresenter: NSObject {
    private var viewController: SignInSceneProtocol?
    
    init(viewController: SignInSceneProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setUpViews()
    }
    
    func didTappedSubmitButton(id: String, pw: String) {
        let signInInfo = SignInInfo(id: id, pw: pw)
        APIService.shared.signInAction(signInInfo: signInInfo) { [weak self] response in
            switch response {
            case .success(let data):
                UserDefaults.standard.set(id, forKey: "signInID")
                KeyChain.shared.addItem(key: data.accessToken, value: "accessToken")
                KeyChain.shared.addItem(key: data.refreshToken, value: "refreshToken")
                self?.viewController?.popScene()
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension SignInPresenter: UITextFieldDelegate {
    
}

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
    func signUp()
}

class SignInPresenter: NSObject {
    private weak var viewController: SignInSceneProtocol?
    
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
                KeyChain.shared.addItem(key: "accessToken", value: data.accessToken)
                KeyChain.shared.addItem(key: "refreshToken", value: data.refreshToken)
                self?.viewController?.popScene()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTappedSignUpButton() {
        viewController?.signUp()
    }
}


extension SignInPresenter: UITextFieldDelegate {
    
}

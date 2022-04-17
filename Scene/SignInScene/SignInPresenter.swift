//
//  SignInPresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/17.
//

import Foundation

protocol SignInSceneProtocol: AnyObject {
    func setUpViews()
}

class SignInPresenter: NSObject {
    private var viewController: SignInSceneProtocol?
    
    init(viewController: SignInSceneProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setUpViews
    }
}



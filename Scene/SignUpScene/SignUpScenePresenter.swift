//
//  SignUpScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/18.
//

import Foundation

protocol SignUpSceneProtocol: AnyObject {
    
}

class SignUpScenePresenter: NSObject {
    private weak var viewController: SignUpSceneProtocol?
    
    init(viewController: SignUpSceneProtocol) {
        self.viewController = viewController
    }    
}

//
//  WritePostScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation

protocol WritePostSceneProtocol: AnyObject {
    
}

class WritePostScenePresenter: NSObject {
    private weak var viewController: WritePostSceneProtocol?
    
    init(viewController: WritePostSceneProtocol) {
        self.viewController = viewController
    }
    
    
}

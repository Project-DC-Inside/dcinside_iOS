//
//  GalleryAddScenePresenter.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation

protocol GalleryAddSceneProtocol: AnyObject {
    
}

class GalleryAddScenePresenter: NSObject {
    private weak var viewController: GalleryAddSceneProtocol?
    
    init(viewController: GalleryAddSceneProtocol?) {
        self.viewController = viewController
    }
    
}

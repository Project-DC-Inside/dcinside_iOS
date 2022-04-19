//
//  GalleryAddSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation
import UIKit

class GalleryAddSceneViewController: UIViewController {
    private lazy var presenter = GalleryAddScenePresenter(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension GalleryAddSceneViewController: GalleryAddSceneProtocol {
    
}

//
//  WritePostSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation
import UIKit

class WritePostSceneViewController: UIViewController {
    private lazy var presenter = WritePostScenePresenter(viewController: self)
    private let galleryInfo: GalleryResponse
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(galleryInfo: GalleryResponse) {
        self.galleryInfo = galleryInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("WrtiePostSceneViewController Error Occured")
    }
}

extension WritePostSceneViewController: WritePostSceneProtocol {
    
}

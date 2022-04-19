//
//  GalleryListSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation
import SnapKit
import UIKit

class GalleryListSceneViewController: UIViewController {
    private var galleryType: String
    
    private lazy var presenter = GalleryListScenePresenter(viewController: self)
    private lazy var galleryListTable: UITableView = {
        let tb = UITableView()
        tb.delegate = presenter
        tb.dataSource = presenter
        
        return tb
    }()
    
    init(galleryType: String) {
        self.galleryType = galleryType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    private lazy var addGalleryButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension GalleryListSceneViewController: GalleryListSceneProtocol {
    func setViews() {
        view.backgroundColor = .systemBackground
        title = "\(galleryType.uppercased()) 갤러리"
        
        navigationItem.rightBarButtonItem = addGalleryButton
        
        [galleryListTable].forEach{
            view.addSubview($0)
        }
        
        galleryListTable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//
//  GalleryPostListSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation
import SnapKit
import UIKit

class GalleryPostListSceneViewController: UIViewController {
    private let gallery: GalleryResponse
    private lazy var presenter = GalleryPostListScenePresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = presenter
        tv.delegate = presenter
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear(galleryID: gallery.id)
    }
    
    init(gallery: GalleryResponse) {
        self.gallery = gallery
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryPostListScene Error Occured")
    }
    
}

extension GalleryPostListSceneViewController: GalleryPostListSceneProtocol {
    func setViews() {
        title = gallery.name
        view.backgroundColor = .systemBackground
        [tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension GalleryPostListSceneViewController {
    
}

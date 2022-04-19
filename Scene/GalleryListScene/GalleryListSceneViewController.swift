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
    
    private lazy var addGalleryButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        
        return button
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "arrow.left")
        button.target = self
        button.action = #selector(didTappedBackButton)
        
        return button
    }()
    
    init(galleryType: String) {
        self.galleryType = galleryType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(galleryType: galleryType)
    }
}

extension GalleryListSceneViewController: GalleryListSceneProtocol {
    func setViews() {
        view.backgroundColor = .systemBackground
        title = "\(galleryType.uppercased()) 갤러리"
        
        navigationItem.rightBarButtonItem = addGalleryButton
        navigationItem.leftBarButtonItem = backButton
        
        [galleryListTable].forEach{
            view.addSubview($0)
        }
        
        galleryListTable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func eraseThisScene() {
        self.dismiss(animated: true)
    }
    
    func reLoadData() {
        galleryListTable.reloadData()
    }
}

extension GalleryListSceneViewController {
    @objc func didTappedBackButton() {
        presenter.didTappedBackButton()
    }
}

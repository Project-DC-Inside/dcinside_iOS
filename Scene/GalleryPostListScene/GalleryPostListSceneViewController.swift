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
        tv.register(GalleryPostListCell.self, forCellReuseIdentifier: "GalleryPostListCell")
        tv.dataSource = presenter
        tv.delegate = presenter
        tv.refreshControl = refreshController
        
        return tv
    }()
    
    private lazy var refreshController: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        
        return refresh
    }()
    
    private lazy var addPostOnGallery: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = "글쓰기"
        btn.target = self
        btn.action = #selector(didTappedAddPostButton)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad(galleryID: gallery.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //presenter.viewWillAppear(galleryID: gallery.id)
    }
    
    @objc func didTappedAddPostButton() {
        presenter.didTappedAddPostButton()
    }
    
    init(gallery: GalleryResponse) {
        self.gallery = gallery
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryPostListScene Error Occured")
    }
    
    @objc func refreshTableView() {
        presenter.refreshTableView()
    }
    
}

extension GalleryPostListSceneViewController: GalleryPostListSceneProtocol {
    func setViews() {
        title = gallery.name
        navigationItem.rightBarButtonItem = addPostOnGallery
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
    
    func moveMakePostScene() {
        let vc = WritePostSceneViewController(galleryInfo: gallery)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func movePostScene(postInfo: PostInfo) {
        let vc = PostSceneViewController(postId: postInfo.id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GalleryPostListSceneViewController {
    
}

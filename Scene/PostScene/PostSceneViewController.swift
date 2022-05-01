//
//  PostSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/28.
//

import Foundation
import SnapKit
import UIKit

class PostSceneViewController: UIViewController {
    private let postId: Int
    private lazy var presenter = PostScenePresenter(viewController: self, postId: postId)
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(TitleLabelCell.self, forCellReuseIdentifier: "TitleLabelCell")
        tv.register(WriterLabelCell.self, forCellReuseIdentifier: "WriterLabelCell")
        tv.register(PostSubInformCell.self, forCellReuseIdentifier: "PostSubInformCell")
        tv.register(ContentCell.self, forCellReuseIdentifier: "ContentCell")
        
        tv.delegate = presenter
        tv.dataSource = presenter
        tv.separatorStyle = .none
        
        return tv
    }()
    
    init(postId: Int) {
        self.postId = postId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("PostScene Error Occured")
    }
    override func viewDidLoad() {
        presenter.viewDidLoad()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
        super.viewWillAppear(animated)
    }
}

extension PostSceneViewController: PostSceneProtocol {
    func viewConfigure() {
        view.addSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func updatePost(postInfo: PostInfo) {
        title = postInfo.title
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

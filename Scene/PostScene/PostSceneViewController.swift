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
    private lazy var modifyButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit,
                                     target: self,
                                     action: #selector(tapModifyButton))
        return button
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
    
    @objc func tapModifyButton() {
        print("TAPP MODIFY")
        presenter.tapModifyButton()
    }
}

extension PostSceneViewController: PostSceneProtocol {
    func presentError(error: Error) {
        let alertVC = UIAlertController(title: "에러 발생", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
    }
    
    func checkUnSignedPassword(postId: Int) {
        let alert = UIAlertController(title: "비밀번호 확인하기", message: nil, preferredStyle: .alert)
        alert.addTextField { [weak self] textField in
            textField.placeholder = "비밀번호"
            textField.isSecureTextEntry = true
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.presenter.checkPassword(text: alert.textFields?[0].text, postId: postId)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func modifyPost(presenter: ModifyPostScenePresenter?) {
        let vc = ModifyPostSceneViewController(presenter: presenter)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func modifyPost(presenter: ModifyPostScenePresenter) {
        let vc = ModifyPostSceneViewController(presenter: presenter)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func viewConfigure() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = modifyButton
        
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

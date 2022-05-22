//
//  WritePostSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation
import UIKit
import SnapKit

class WritePostSceneViewController: UIViewController {
    private lazy var presenter = WritePostScenePresenter(viewController: self)
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = presenter
        tv.separatorStyle = .singleLine
        tv.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")
        tv.register(ContentTextViewCell.self, forCellReuseIdentifier: "ContentTextViewCell")
        
        return tv
    }()
    private lazy var submitPost: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = "작성"
        btn.target = self
        btn.action = #selector(didTappedSubmitButton)
        
        return btn
    }()
    
    private let galleryInfo: GalleryResponse
    
    init(galleryInfo: GalleryResponse) {
        self.galleryInfo = galleryInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("WrtiePostSceneViewController Error Occured")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @objc func didTappedSubmitButton() {
        presenter.didTappedSubmitButton(galleryId: galleryInfo.id)
    }
}

extension WritePostSceneViewController: WritePostSceneProtocol {
    func setViewLayout() {
        navigationItem.rightBarButtonItem = submitPost
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func setViewsAttribute() {
        view.backgroundColor = .systemBackground
        title = "글쓰기"
    }
    
    func postSuccess() {
        let alertVC = UIAlertController(title: "포스트 등록", message: "성공!", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true)
    }
    
    func postFailed(_ error: String) {
        let alertVC = UIAlertController(title: "포스트 실패", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alertVC.addAction(action)
        self.present(alertVC, animated: true)
    }
}

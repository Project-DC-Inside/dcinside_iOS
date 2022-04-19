//
//  GalleryAddSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/19.
//

import Foundation
import SnapKit
import UIKit

class GalleryAddSceneViewController: UIViewController {
    private lazy var presenter = GalleryAddScenePresenter(viewController: self)
    private let type: String
    
    init(type: String) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(GalleryNameCells.self, forCellReuseIdentifier: "GalleryNameCells")
        tv.dataSource = presenter
        
        return tv
    }()
    
    private lazy var submitButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = "제출"
        btn.target = self
        btn.action = #selector(didTappedSubmitButton)
        
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    @objc func didTappedSubmitButton() {
        presenter.didTappedSubmitButton(type: type)
    }
}

extension GalleryAddSceneViewController: GalleryAddSceneProtocol {
    func setViews() {
        navigationItem.rightBarButtonItem = submitButton
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func setAlert(title: String, content: String, success: Bool) {
        let alertVC = UIAlertController(title: title, message: content, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            if success {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        alertVC.addAction(action)
        
        self.present(alertVC, animated: true)
    }
}

//
//  ModifyPostSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/05/22.
//

import Foundation
import UIKit

class ModifyPostSceneViewController: UIViewController {
    private let presenter: ModifyPostScenePresenter?
    
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
    
    init(presenter: ModifyPostScenePresenter?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter?.setViewController(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ModifyScene Error Occured!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    @objc func didTappedSubmitButton() {
        presenter?.didTappedSubmitButton()
    }
    
}

extension ModifyPostSceneViewController: ModifyPostSceneProtocol {
    func setLayout() {
        view.addSubview(tableView)
        
        self.navigationItem.rightBarButtonItem = submitPost
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setAlert(message: String) {
        let alertVC = UIAlertController(title: "정보", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(action)
        
        self.present(alertVC, animated: true)
    }
}

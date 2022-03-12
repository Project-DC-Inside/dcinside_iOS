//
//  MakePostSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MakePostSceneViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MakePostScene Error Occured")
    }
    
    private func attribute() {
        title = "글 쓰기"
        view.backgroundColor = .white
        
        submitButton.title = "제출"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell") // 0
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: "DetailWriteFormCell")
        // 0
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind() {
        
    }
    
}

//
//  NoticeBoardViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NoticeBoardViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let noticePostListView = UITableView()
    let addPostButton = UIBarButtonItem()
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("NoticeBoard Scene Error")
    }
    
    private func layout() {
        
    }
    
    private func attribute() {
        addPostButton.image = UIImage(systemName: "plus")
        
        title = "NoticePost"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = addPostButton
        
    }
    
    func bind(_ viewModel: NoticeBoardViewModel) {
        addPostButton.rx.tap
            .bind(to: viewModel.addPost)
            .disposed(by: disposeBag)
        
        viewModel.makePostScene
            .drive(onNext: { str in
                let makePost = MakePostSceneViewController()
                self.navigationController?.pushViewController(makePost, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

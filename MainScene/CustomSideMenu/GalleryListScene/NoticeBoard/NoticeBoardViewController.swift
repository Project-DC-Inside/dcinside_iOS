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
    
    func bind(_ viewModel: NoticeBoardViewModel) {
        addPostButton.rx.tap
            .bind(to: viewModel.addPost)
            .disposed(by: disposeBag)
        
        viewModel.makePostScene
            .drive(onNext: { str in
                let vm = MakePostSceneViewModel()
                let makePost = MakePostSceneViewController()
                makePost.bind(vm)
                self.navigationController?.pushViewController(makePost, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.cellData.drive(noticePostListView.rx.items) { tableVew, row, data in
            let cell = tableVew.dequeueReusableCell(withIdentifier: "NoticePostCell", for: IndexPath(row: row, section: 0)) as! NoticePostCell
            cell.label.text = data.name
            return cell
        }.disposed(by: disposeBag)
        
    }
    
    private func layout() {
        view.addSubview(noticePostListView)
        
        noticePostListView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func attribute() {
        addPostButton.image = UIImage(systemName: "plus")
        
        title = "NoticePost"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = addPostButton
        
        noticePostListView.register(NoticePostCell.self, forCellReuseIdentifier: "NoticePostCell")
    }
}

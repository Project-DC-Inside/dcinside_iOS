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
    
    let noticePostListView = UITableView()
    
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
        title = "NoticePost"
        view.backgroundColor = .systemBackground
        
    }
    
    func bind(_ viewModel: NoticeBoardViewModel) {
        
    }
}

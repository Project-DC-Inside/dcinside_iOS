//
//  GalleryListViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class GalleryListViewController: UIViewController {
    let galleryListTable = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryList Error")
    }
    
    func bind(_ viewModel: GalleryListViewModel){
        
    }
    
    private func attribute() {
        title = "GalleryList"
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        galleryListTable.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

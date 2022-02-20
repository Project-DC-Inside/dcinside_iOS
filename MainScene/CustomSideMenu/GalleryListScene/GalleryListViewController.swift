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
    let viewModel = GalleryListViewModel()
    let galleryListTable = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryList Error")
    }
    
    func bind(){
        
    }
    
    private func attribute() {
        title = "GalleryList"
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        view.addSubview(galleryListTable)
        
        galleryListTable.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

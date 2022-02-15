//
//  GalleryListViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import UIKit
import RxCocoa
import RxSwift
class GalleryListViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryList Error")
    }
    
    func bind(_ viewModel: GalleryListViewModel){
        view.backgroundColor = .white
    }
}

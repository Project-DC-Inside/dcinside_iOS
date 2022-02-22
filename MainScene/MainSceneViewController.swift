//
//  MainSceneViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/12.
//

import Foundation
import SideMenu
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainSceneViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let sideMenuButton = UIBarButtonItem()
    
    let searchBarController = UISearchController()
    let tableView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainSceneView Error Occured!")
    }
    
    func bind(_ viewModel: MainSceneViewModel) {
        
        viewModel.presentSideMenu
            .emit(to: self.rx.setSide)
            .disposed(by: disposeBag)
        
        sideMenuButton.rx.tap
            .bind(to: viewModel.sideMenuButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "Deep Forest"
        sideMenuButton.style = .done
        sideMenuButton.image = UIImage(systemName: "line.horizontal.3")
        
        searchBarController.searchBar.placeholder = "검색어"
        searchBarController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchBarController
        navigationItem.leftBarButtonItem = sideMenuButton
        
        view.backgroundColor = .white
    }
    
    private func layout() {
        [
            tableView
        ].forEach { view.addSubview($0) }
    }
}

extension Reactive where Base:MainSceneViewController {
    var setSide: Binder<Void> {
        return Binder(base) { base, data in
            print("BASEBASE")
            let vc = SideMenuViewController()
            let sideNav = SideMenuNavigation(rootViewController: vc)
            base.present(sideNav, animated: true, completion: nil)
        }
    }
}

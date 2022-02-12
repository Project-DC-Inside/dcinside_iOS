//
//  SideMenuViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/12.
//

import Foundation
import UIKit
import SideMenu
import RxCocoa
import RxSwift


class SideMenuViewController : UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind(SideMenuViewModel())
        attribute()
        layout()
    }
    
    func bind(_ viewModel: SideMenuViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                let cell = tv.dequeueReusableCell(withIdentifier: "SideMenuCell", for: IndexPath(row: row, section: 0)) as! SideMenuCell
                cell.selectionStyle = .none
                cell.titleLabel.text = data
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("SideMenu ViewController Error Occured!")
    }
    
    private func attribute() {
        view.backgroundColor = .white
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: "SideMenuCell")
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

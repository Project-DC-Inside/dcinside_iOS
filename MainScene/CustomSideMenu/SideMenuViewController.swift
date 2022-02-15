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
    let signInButton = UIButton()
    let nicknameInfo = UILabel()
    let noticeButton = UIButton()
    let settingButton = UIButton()
    let logo = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind(SideMenuViewModel())
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("SideMenu ViewController Error Occured!")
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

        signInButton.rx.tap
            .bind(to: viewModel.signInButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.push
            .drive(onNext: { viewModel in
                let viewController = SignInViewController()
                viewController.bind(viewModel)                
                self.show(viewController, sender: nil)
            })
    }
    
    
    private func attribute() {
        signInButton.setImage(UIImage(systemName: "power.circle"), for: .normal)
        
        nicknameInfo.textAlignment = .center
        nicknameInfo.numberOfLines = 0
        
        noticeButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        
        settingButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        
        logo.text = "DF"
        logo.textAlignment = .center
        
        view.backgroundColor = .white
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: "SideMenuCell")
    }
    
    private func layout() {
        
        
        lazy var blankLabel = UILabel()
        lazy var blankLabel2 = UILabel()
        lazy var blankLabel3 = UILabel()
        lazy var blankLabel4 = UILabel()
        
        lazy var logStack = UIStackView(arrangedSubviews: [blankLabel4, signInButton])
        lazy var stackView = UIStackView(arrangedSubviews: [nicknameInfo, logStack])
        lazy var btnView = UIStackView(arrangedSubviews: [settingButton, noticeButton])
        lazy var stackTop = UIStackView(arrangedSubviews: [logo, blankLabel, btnView])
        
        lazy var HeaderStack = UIStackView(arrangedSubviews: [stackTop, stackView])
        
        stackView.spacing = 4.0
        stackView.distribution = .fillEqually
        
        btnView.spacing = 0.0
        btnView.distribution = .fillEqually
        
        stackTop.spacing = 0.0
        stackTop.distribution = .fillEqually
        
        HeaderStack.axis = .vertical
        
        HeaderStack.spacing = 15.0
        HeaderStack.distribution = .fillEqually
        
        view.addSubview(HeaderStack)
        view.addSubview(tableView)
        
        HeaderStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        
    }
}

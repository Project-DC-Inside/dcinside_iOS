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
        
        attribute()
        layout()
        bind(SideMenuViewModel())
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
            .map { Void -> Bool in
                if self.signInButton.image(for: .normal) == UIImage(systemName: "power.circle") {
                    return true
                }else {
                    return false
                    
                }
            }
            .bind(to: viewModel.signInButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.push
            .drive(onNext: { viewModel in
                guard let viewModel = viewModel else {
                    self.nicknameInfo.text = "로그인 하세요!"
                    self.signInButton.setImage(UIImage(systemName: "power.circle"), for: .normal)
                    return
                }
                let viewController = SignInViewController()
                viewController.bind(viewModel)                
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.findNickName
            .subscribe(onNext: {
                self.nicknameInfo.text = $0
                self.signInButton.setImage(UIImage(systemName: "power.circle.fill"), for: .normal)
            }, onError: { error in
                print(error)
                self.nicknameInfo.text = "로그인 하세요!"
            })
            .disposed(by: disposeBag)
        
        
        
        tableView.rx.itemSelected
            .bind(to: viewModel.selectTableItems)
            .disposed(by: disposeBag)
        
        viewModel.nextSceneInfo.drive(onNext: {
            switch $0{
            case .galleryListScene:
                let galleryScene = GalleryListViewController()
                self.navigationController?.pushViewController(galleryScene, animated: true)
            case .managingScene:
                let managingScene = ManagingSceneViewController()
                self.navigationController?.pushViewController(managingScene, animated: true)
            case .visitListScene:
                let visitListScene = VisitListSceneViewController()
                self.navigationController?.pushViewController(visitListScene, animated: true)
            default:
                let viewedScene = ViewedSceneViewController()
                self.navigationController?.pushViewController(viewedScene, animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    
    private func attribute() {
        signInButton.setImage(UIImage(systemName: "power.circle"), for: .normal)
        
        nicknameInfo.textAlignment = .center
        nicknameInfo.numberOfLines = 0
        nicknameInfo.font = .systemFont(ofSize: 12)
        
        noticeButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        
        settingButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        
        logo.text = "Deep Forest"
        logo.font = .systemFont(ofSize: 13)
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
        lazy var stackTop = UIStackView(arrangedSubviews: [logo, btnView])
        
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
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        
    }
}

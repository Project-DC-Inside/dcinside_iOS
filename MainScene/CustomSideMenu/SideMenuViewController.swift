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
    
    let wrappTableView = UIView()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let signInButton = UIButton()
    let nicknameInfo = UILabel()
    let noticeButton = UIButton()
    let settingButton = UIButton()
    let logo = UILabel()
    
    lazy var HeaderStack = UIStackView()
    
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
            case .majorGallery:
                let galleryScene = GalleryListViewController()
                let viewModel = GalleryListViewModel(gallery: "MAJOR")
                galleryScene.bind(viewModel: viewModel)
                self.navigationController?.pushViewController(galleryScene, animated: true)
            case .minorGallery:
                let galleryScene = GalleryListViewController()
                let viewModel = GalleryListViewModel(gallery: "MINOR")
                galleryScene.bind(viewModel: viewModel)
                self.navigationController?.pushViewController(galleryScene, animated: true)
            case .miniGallery:
                let galleryScene = GalleryListViewController()
                let viewModel = GalleryListViewModel(gallery: "MINI")
                galleryScene.bind(viewModel: viewModel)
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
        
//        nicknameInfo.textAlignment = .center
        nicknameInfo.numberOfLines = 0
        nicknameInfo.font = .systemFont(ofSize: 12)
        
        noticeButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        
        settingButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        
        logo.text = "Deep Forest"
        logo.font = .systemFont(ofSize: 13)
        
        view.backgroundColor = .white
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: "SideMenuCell")
    }
    
    private func layout() {
        
        
        lazy var blankLabel = UILabel()
        lazy var blankLabel2 = UILabel()
        lazy var blankLabel3 = UILabel()
        lazy var blankLabel4 = UILabel()
        
        //lazy var logStack = UIStackView(arrangedSubviews: [blankLabel4, signInButton])
        lazy var stackView = UIStackView(arrangedSubviews: [nicknameInfo, signInButton])
        lazy var btnView = UIStackView(arrangedSubviews: [settingButton, noticeButton])
        lazy var stackTop = UIStackView(arrangedSubviews: [logo, btnView])
        
        HeaderStack = UIStackView(arrangedSubviews: [stackTop, stackView])
    
        stackView.spacing = 4.0
        
        btnView.spacing = 10.0
        
        stackTop.spacing = 0.0
        
        HeaderStack.axis = .vertical
        
        HeaderStack.spacing = 15.0
        HeaderStack.distribution = .fillEqually
        
        view.addSubview(HeaderStack)
        view.addSubview(wrappTableView)
        
        HeaderStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        wrappTableView.snp.makeConstraints {
            $0.top.equalTo(HeaderStack.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        wrappTableView.addSubview(tableView)
        
        logo.snp.makeConstraints {
            $0.leading.equalTo(stackTop.snp.leading).offset(10)
        }
        
        nicknameInfo.snp.makeConstraints {
            $0.leading.equalTo(stackTop.snp.leading).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints {
            $0.width.height.equalTo(stackTop.snp.height)
        }
        
        noticeButton.snp.makeConstraints {
            $0.width.height.equalTo(stackTop.snp.height)
            $0.leading.equalTo(settingButton.snp.trailing).offset(20)
        }
        
        signInButton.snp.makeConstraints {
            $0.width.height.equalTo(stackView.snp.height)
        }
    }
}

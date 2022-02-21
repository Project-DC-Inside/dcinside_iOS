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
    let disposeBag = DisposeBag()
    
    let galleryListTable = UITableView()
    let addGalleryButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryList Error")
    }
    
    func bind(viewModel: GalleryListViewModel){
        viewModel.cellData.drive(galleryListTable.rx.items) { tv, row, data in
            let cell = tv.dequeueReusableCell(withIdentifier: "GalleryListTableCell", for: IndexPath(row: row, section: 0)) as! GalleryListTableCell
            //cell.selectionStyle = .none
            cell.label.text = data.name
            return cell
        }
        .disposed(by: disposeBag)
        
        viewModel.buttonExist
            .drive(onNext: {
                if !$0 { self.navigationItem.rightBarButtonItem = nil }
            })
            .disposed(by: disposeBag)
        
        viewModel.actionAddGallery
            .drive(onNext: {
                let galleryScene = AddGalleryViewController()
                galleryScene.bind(AddGalleryViewModel(type: $0))
                self.navigationController?.pushViewController(galleryScene, animated: true)
            }).disposed(by: disposeBag)
        
        addGalleryButton.rx.tap
            .bind(to: viewModel.addGallery)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "GalleryList"
        
        view.backgroundColor = .systemBackground
        
        galleryListTable.register(GalleryListTableCell.self, forCellReuseIdentifier: "GalleryListTableCell")
        
        addGalleryButton.image = UIImage(systemName: "plus")
    }
    
    private func layout() {
        view.addSubview(galleryListTable)
        
        navigationItem.rightBarButtonItem = addGalleryButton
        
        galleryListTable.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

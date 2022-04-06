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
        galleryListTable.rx.modelSelected(Gallery.self)
            .do { _ in
                guard let indexPath = self.galleryListTable.indexPathForSelectedRow else { return }
                self.galleryListTable.deselectRow(at: indexPath, animated: true)
            }
            .bind(to: viewModel.modelSelected)
            .disposed(by: disposeBag)
        
        viewModel.push
            .drive(onNext: { gallery in
                let viewModel = NoticeBoardViewModel(gallery.name)
                let viewController = NoticeBoardViewController()
                viewController.bind(viewModel)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.titleNaming.drive(onNext: {
            self.title = $0
        }).disposed(by: disposeBag)
        
        viewModel.cellData.drive(galleryListTable.rx.items) { tv, row, data in
            let cell = tv.dequeueReusableCell(withIdentifier: "GalleryListTableCell", for: IndexPath(row: row, section: 0)) as! GalleryListTableCell
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

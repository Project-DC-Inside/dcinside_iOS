//
//  GalleryListViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import Foundation
import RxSwift
import RxCocoa

struct GalleryListViewModel {
    let disposeBag = DisposeBag()
    // viewModel -> view
    let cellData: Driver<[Gallery]>
    let buttonExist: Driver<Bool>
    let actionAddGallery: Driver<String>
    let titleNaming: Driver<String>
    let push: Driver<Int>
    //let itemDeSelected: Driver<Int>
    
    // view -> viewModel
    let addGallery = PublishRelay<Void>()
    let itemSelected = PublishRelay<Int>()
    
    init(gallery: String) {
        
        titleNaming = Observable.create { observer in
            observer.onNext(gallery)
            observer.onCompleted()
            return Disposables.create()
        }.asDriver(onErrorDriveWith: .empty())
        
        cellData = APIService.shared.FetchGalleryList(type: gallery)
            .map {
                switch $0 {
                case .success(let data):
                    return data
                case .failure:
                    return []
                }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        buttonExist = Observable.create { observer in
            if gallery == "MAJOR" {
                observer.onNext(false)
            }
            observer.onNext(true)
            observer.onCompleted()
            return Disposables.create()
        }.asDriver(onErrorDriveWith: .empty())
        
        actionAddGallery = addGallery
            .map{ _ -> String in
                return gallery
            }
            .asDriver(onErrorDriveWith: .empty())
        
        self.push = itemSelected
            .asDriver(onErrorDriveWith: .empty())
        
    }
}

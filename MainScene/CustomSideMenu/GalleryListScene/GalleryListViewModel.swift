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
    
    // view -> viewModel
    
    init() {
        cellData = APIService.shared.fetchGalleryList()
            .map {
                switch $0 {
                case .success(let data):
                    return data
                case .failure:
                    return []
                }
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}

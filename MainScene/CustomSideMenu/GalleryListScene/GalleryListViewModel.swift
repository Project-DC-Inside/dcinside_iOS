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
    init() {
        APIService.shared.fetchGalleryList().subscribe(onNext: {
            print($0)
        })
            .disposed(by: disposeBag)
    }
}

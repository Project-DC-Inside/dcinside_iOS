//
//  NoticeBoardViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation
import RxSwift
import RxCocoa

struct NoticeBoardViewModel{
    let galleryName: String?
        
    // View -> viewModel
    let addPost = PublishRelay<Void>()
    
    // viewModel -> View
    let makePostScene: Driver<String>
    
    init(_ galleryName: String?) {
        self.galleryName = galleryName
        
        makePostScene = addPost
            .map { _ -> String in
                guard let ret = galleryName else { return "" }
                return ret
            }
            .asDriver(onErrorDriveWith: .empty())
    }
    
}

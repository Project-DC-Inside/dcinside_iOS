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
    
    var dummyPosts = PublishRelay<[Post]>()
    
    // viewModel -> View
    let makePostScene: Driver<String>
    let cellData: Driver<[Post]>
    
    init(_ galleryName: String?) {
        self.galleryName = galleryName
        
        makePostScene = addPost
            .map { _ -> String in
                guard let ret = galleryName else { return "" }
                return ret
            }
            .asDriver(onErrorDriveWith: .empty())
        
        let dummy = Observable<[Post]>.create { observe in
            observe.onNext([Post(name: "HELLO"), Post(name: "HELLO2"), Post(name: "HELLO3"), Post(name: "HELLO4"), Post(name: "HELLO5")])
            return Disposables.create()
        }
        
        cellData = dummy
            .asDriver(onErrorDriveWith: .empty())
        
        
        
        
    }
    
}

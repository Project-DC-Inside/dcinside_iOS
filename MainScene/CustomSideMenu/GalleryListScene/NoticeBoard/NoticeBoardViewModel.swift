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
        print("HH")
        self.galleryName = galleryName
        
        addPost.subscribe(onNext: {
            print("FF")
        })
        
        makePostScene = addPost
            .map { _ -> String in
                print("PPP")
                guard let ret = galleryName else { return "" }
                print(ret)
                return ret
            }
            .asDriver(onErrorDriveWith: .empty())
    }
    
}

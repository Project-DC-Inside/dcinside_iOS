//
//  SideMenuViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/12.
//

import Foundation
import RxSwift
import RxCocoa

enum NextSceneEnum {
    case galleryListScene
    case managingScene
    case visitListScene
    case viewdListScene
}

struct SideMenuViewModel {
    
    // view -> ViewModel
    let push: Driver<SignInViewModel?>
    let findNickName: Observable<String?>
    let nextSceneInfo: Driver<NextSceneEnum>
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    let signInButtonTapped = PublishRelay<Bool>()
    let selectTableItems = PublishRelay<IndexPath>()
    let logOff = PublishRelay<Void>()
    
    let menu = [
        "갤러리 리스트",
        "운영 갤러리",
        "방문한 갤러리",
        "최근 본 글"
        
    ]
    
    init() {
        
        self.cellData = Observable
            .of(menu)
            .asDriver(onErrorJustReturn: [])
        
        let signInViewModel = SignInViewModel()        
        
        self.findNickName = KeyChain.shared.getInfo(key: KeyChain.nickName)
        
        self.nextSceneInfo = self.selectTableItems.map{ ip -> NextSceneEnum in
            switch ip.row {
            case 0:
                return .galleryListScene
            case 1:
                return .managingScene
            case 2:
                return .visitListScene
            default:
                return .viewdListScene
            }
        }.asDriver(onErrorDriveWith: .empty())
        
        self.push = signInButtonTapped
            .map{ tap -> SignInViewModel? in
                if tap  {
                    return signInViewModel
                }else {
                    KeyChain.shared.deleteItem(key: KeyChain.nickName)
                    KeyChain.shared.deleteItem(key: KeyChain.token)
                    KeyChain.shared.deleteItem(key: KeyChain.refresh)
                    return nil
                    
                }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        
        
    }
}

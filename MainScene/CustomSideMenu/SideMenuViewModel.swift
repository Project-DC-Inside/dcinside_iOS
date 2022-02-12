//
//  SideMenuViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/12.
//

import Foundation
import RxSwift
import RxCocoa

struct SideMenuViewModel {
    // view -> ViewModel
    
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    
    
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
        
        
    }
}

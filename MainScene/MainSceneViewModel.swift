//
//  MainSceneViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/12.
//

import Foundation
import RxSwift
import RxCocoa

struct MainSceneViewModel {
    // viewModel => view
    let presentSideMenu: Signal<Void>
    
    // view -> ViewModel
    let sideMenuButtonTapped = PublishRelay<Void>()    
    
    init() {
        print("INIT")
        let map = "MAP"
    
        
        self.presentSideMenu = sideMenuButtonTapped
            .asSignal(onErrorSignalWith: .empty())
        
            //.asSignal(onErrorSignalWith: .empty())
    }
    
}

//
//  MakePostSceneViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation
import RxSwift
import RxCocoa


struct MakePostSceneViewModel {
    let writeFormCellViewModel = WriteFormCellViewModel()
    let titleFieldCellViewModel = TitleFieldCellViewModel()
    
    // viewModel -> View
    let cellData: Driver<[String]>
    
    init() {
        let title = Observable.just("글 제목")
        let detail = Observable.just("내용 입력하세용")
        
        self.cellData = Observable
            .combineLatest(title, detail) { [$0, $1] }
            .asDriver(onErrorDriveWith: .empty())
        
        let titleContent = titleFieldCellViewModel
            .titleText
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 글 제목 입력해주세요"]: []}
        
        let writeContent = writeFormCellViewModel
            .contentValue
            .map{ $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 내용 입력 해주세용"]: []}
        
        
        
    }
}

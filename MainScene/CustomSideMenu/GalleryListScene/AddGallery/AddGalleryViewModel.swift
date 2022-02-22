//
//  AddGalleryViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/22.
//

import Foundation
import RxCocoa
import RxSwift

struct AddGalleryViewModel {
    let type: String
    let titleTextFieldViewModel = TitleTextFieldCellViewModel()
    let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
    
    //ViewModel -> View
    let cellData: Driver<[String]>
    let presentAlert: Signal<Alert>
    
    //View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    let submitButtonTapped = PublishRelay<Void>()
    
    init(model: AddGalleryModel = AddGalleryModel(), type: String) {
        self.type = type
        let title = Observable.just("글 제목")
        let detail = Observable.just("내용을 입력하세요.")
        
        self.cellData = Observable
            .combineLatest(title, detail) { [$0, $1] }
            .asDriver(onErrorJustReturn: [])
        
        let titleMessage = titleTextFieldViewModel
            .titleText
            .map{ $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 글 제목을 입력해주세요"]: []}
                
        let detailMessage = detailWriteFormCellViewModel
            .contentValue
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- 내용 입력해 줘잉"]: []}
        
        let errorMessage = Observable
            .combineLatest(titleMessage, detailMessage){ $0 + $1 }
        
        let makeShare = titleTextFieldViewModel.titleText.filter { $0 != nil }
            .map{ name -> Gallery in
                Gallery(type: type, name: name! )}        
        
        let submitGallery = submitButtonTapped.withLatestFrom(titleTextFieldViewModel.titleText.filter{ $0 != nil } ){ _, name in
                return name!
            }
            .flatMap { return APIService.shared.MakeGallery(type: type, title: $0) }
        
        self.presentAlert = submitGallery.compactMap { data -> Alert in
            return model.setAlert(action: data)
        }.asSignal(onErrorSignalWith: .empty())
    }
}

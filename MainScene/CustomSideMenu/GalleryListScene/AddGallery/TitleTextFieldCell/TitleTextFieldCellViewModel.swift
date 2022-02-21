//
//  TitleTextFieldCellViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/22.
//

import RxSwift
import RxCocoa

struct TitleTextFieldCellViewModel {
    let titleText = PublishRelay<String?>()
}

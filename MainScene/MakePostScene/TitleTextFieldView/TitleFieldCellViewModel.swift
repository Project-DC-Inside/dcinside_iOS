//
//  TitleTextFieldViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/03/13.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

struct TitleFieldCellViewModel {
    let titleText = PublishRelay<String?>()
}

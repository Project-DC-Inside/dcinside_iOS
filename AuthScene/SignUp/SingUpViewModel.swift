//
//  SingUpViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/16.
//

import Foundation
import RxCocoa
import RxSwift

struct SignUpViewModel {
    // viewModel -> view
    let idConstraint: Driver<LabelTextwithColor>
    let nickNameConstraint: Driver<LabelTextwithColor>
    let passwordConstraint: Driver<LabelTextwithColor>
    let emailCert: Driver<Void>
    let signUpAlert: Signal<Alert>
    
    // view -> viewModel
    let idText = PublishRelay<String?>()
    let nickNameText = PublishRelay<String?>()
    let passwordText = PublishRelay<String?>()
    let rePasswordText = PublishRelay<String?>()
    let emailText = PublishRelay<String?>()
    let emailCertiBtn = PublishRelay<Void>()
    let signUpSubmit = PublishRelay<Void>()
    
    init(model: SignUpModel = SignUpModel()) {
        self.idConstraint = idText.map {
            guard let id = $0 else { return ("5자 ~ 20자 영문, 숫자로 입력해주세요.", .gray) }
            return model.idChecker(id: id)
        }.asDriver(onErrorDriveWith: .empty())
        
        self.nickNameConstraint = nickNameText.map {
            guard let nickname = $0 else { return ("20자 내외로 닉네임 입력해주세요! :)", .gray) }
            return model.nickNameChecker(nickName: nickname)
        }.asDriver(onErrorDriveWith: .empty())
        
        self.passwordConstraint = Observable.combineLatest(passwordText, rePasswordText) {
            guard let pass = $0 else { return ("영문, 숫자 8~20자 내외로 해주세요", .gray)}
            guard let repass = $1 else { return ("영문, 숫자 8~20자 내외로 해주세요", .gray)}
            return model.passwordChecker(pass: pass, repass: repass)
        }.asDriver(onErrorDriveWith: .empty())
        
        self.emailCert = emailCertiBtn.asDriver(onErrorDriveWith: .empty())
        
//        let emit = Observable.combineLatest(idText, nickNameText, passwordText, rePasswordText) {
//            
//        }
    }
}

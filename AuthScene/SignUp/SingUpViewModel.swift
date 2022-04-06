//
//  SingUpViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/16.
//

import Foundation
import RxCocoa
import RxSwift

enum SignUpAction {
    case success
    case error
}

struct SignUpViewModel {
    let disposeBag = DisposeBag()
    // viewModel -> view
    let idConstraint: Driver<LabelTextwithColor>
    let nickNameConstraint: Driver<LabelTextwithColor>
    let passwordConstraint: Driver<LabelTextwithColor>
    let emailCerti: Driver<Bool>
    let submitChecker: Signal<Bool>
    let submitResult: Signal<Alert>
    
    //let checkAllPropertyOfSignUp: Driver<SignUpInfo?>
    //let signUpAlert: Signal<Alert>
    
    // view -> viewModel
    let idText = BehaviorRelay<String>(value: "")
    let nickNameText = BehaviorRelay<String>(value: "")
    let passwordText = BehaviorRelay<String>(value: "")
    let rePasswordText = BehaviorRelay<String>(value: "")
    let emailText = BehaviorRelay<String>(value: "")
    
    let emailCertiBtn = PublishRelay<Void>()
    let signUpSubmit = PublishRelay<Void>()    
    
    init(model: SignUpModel = SignUpModel()) {
        idConstraint = idText.map { model.idChecker(id: $0) }.asDriver(onErrorDriveWith: .empty())
        nickNameConstraint = nickNameText.map { model.nickNameChecker(nickName: $0) }.asDriver(onErrorDriveWith: .empty())
        passwordConstraint = Observable.combineLatest(passwordText, rePasswordText) { model.passwordChecker(pass: $0, repass: $1) }.asDriver(onErrorDriveWith: .empty())
        
        let idChecker = idText.map{ return $0.count >= 5 && $0.count <= 20 }
        let nickChecker = nickNameText.map{ return $0.count > 0 && $0.count <= 20}
        let passwordChecker = Observable.combineLatest(passwordText, rePasswordText) { (pw, re) -> Bool in pw.count > 0 && pw == re }
        let emailChecker = emailText.map { return model.isValidEmail(email: $0) }
        
        submitChecker = Observable.combineLatest(idChecker, nickChecker, passwordChecker, emailChecker) {
            print( $0 && $1 && $2 && $3 )
            return $0 && $1 && $2 && $3 }
            .asSignal(onErrorSignalWith: .empty())
                
        let submitInfo = BehaviorSubject.combineLatest(idText, passwordText, emailText, nickNameText) {
            return SignUpInfo(id: $0, password: $1, email: $2, nickName: $3)
        }
        
        let submitNetwork = signUpSubmit.withLatestFrom(submitInfo){ _, signUp in
            print(signUp)
            return signUp
        }.flatMap { return APIService.shared.SignUpAPI(signUp: $0).retry(2) }
        
        
        self.submitResult = submitNetwork.compactMap { data -> Alert in
            return model.setAlert(action: data)            
        }.asSignal(onErrorSignalWith: .empty())
        
        self.emailCerti = emailCertiBtn.withLatestFrom(emailText) { _, _ -> Bool in
            return true
        }.asDriver(onErrorDriveWith: .empty())
    }
    
}

//
//  SignInViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import Foundation
import RxCocoa
import RxSwift

struct SignInViewModel {
    let disposeBag = DisposeBag()
    
    // viewModel -> view
    let requestData: Driver<Void>
    
    // view -> viewModel
    let submitButtonTapped = PublishRelay<Void>()
    let idInfo = BehaviorRelay<String?>(value: "")
    let pwInfo = BehaviorRelay<String?>(value: "")
    
    let logInfo: Observable<LoginInfo>
    
    init() {
        let tapped = self.submitButtonTapped
            .asObservable()
      
        self.logInfo = Observable.combineLatest(idInfo, pwInfo)
            .compactMap { info -> LoginInfo? in
                guard let id = info.0, let pw = info.1 else { return nil }
                print(LoginInfo(id: id, pw: pw))
                return LoginInfo(id: id, pw: pw)
            }.asObservable()
        
        let requestResult = tapped.withLatestFrom(self.logInfo) { _, LoginInfo in
            print(LoginInfo)
            return LoginInfo
        }.flatMapLatest { info in
            return APIService.shared.SignInAPI(signIn: info)
        }
        
        requestData = requestResult
            .compactMap { data -> Void in
                switch data {
                case let .success(token):
                    KeyChain.shared.addItem(key: "token", value: token.token)
                    KeyChain.shared.addItem(key: "token", value: token.refreshToken)
                    print("SUCCESSTOKEN")
                    return Void()
                case let .failure(e) :
                    print(e.localizedDescription)
                    return Void()
                default:
                    return Void()
                }
            }
            .asDriver(onErrorDriveWith: .empty())
        

    }
}

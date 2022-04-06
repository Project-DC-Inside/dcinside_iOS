//
//  SignInViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import Foundation
import RxCocoa
import RxSwift
import RxAlamofire
import Alamofire

enum SignInAction {
    case success
    case nonExist
    case networkErr
}

struct SignInViewModel {
    let disposeBag = DisposeBag()
    
    // viewModel -> view
    //let requestData: Driver<SignInAction>
    let errorCheck: Signal<Alert>
    let nextCheck: Driver<Void>
    let signUp: Driver<Void>
    
    // view -> viewModel
    let submitButtonTapped = PublishRelay<Void>()
    let signUpButtonTapped = PublishRelay<Void>()
    let idInfo = BehaviorRelay<String?>(value: "")
    let pwInfo = BehaviorRelay<String?>(value: "")
    
    let logInfo: Observable<SignInInfo>
    let idDriver: Signal<String?>
    
    let session = Session.default
    
    init(model: SignInModel = SignInModel()) {
        let tapped = self.submitButtonTapped
            .asObservable()
        
        signUp = self.signUpButtonTapped
            .asDriver(onErrorDriveWith: .empty())
        
        self.logInfo = Observable.combineLatest(idInfo, pwInfo)
            .compactMap { info -> SignInInfo? in
                guard let id = info.0, let pw = info.1 else { return nil }
                print(SignInInfo(id: id, pw: pw))
                return SignInInfo(id: id, pw: pw)
            }.asObservable()
        
        let requestResult = tapped.withLatestFrom(self.logInfo) { _, LoginInfo in
            return LoginInfo
        }.flatMapLatest { info in
            return APIService.shared.SignInAPI(signIn: info).compactMap { data -> SignInAction in
                switch data{
                case let .success(result):
                    print(result)
                    guard let token = result.token else { return .nonExist }
                    if let isToken = KeyChain.shared.getItem(key: KeyChain.token) {
                        KeyChain.shared.updateItem(value: token.token, key: KeyChain.token)
                        KeyChain.shared.updateItem(value: token.refreshToken, key: KeyChain.token)
                        KeyChain.shared.updateItem(value: info.id, key: KeyChain.nickName)
                        return .success
                    }
                    KeyChain.shared.addItem(key: KeyChain.token, value: token.token)
                    KeyChain.shared.addItem(key: KeyChain.refresh, value: token.refreshToken)
                    KeyChain.shared.addItem(key: KeyChain.nickName, value: info.id)
                    print("SUCCESSTOKEN")
                    return .success
                case let .failure(e) :
                    print(e.localizedDescription)
                    return .networkErr
                default:
                    return .networkErr
                }
            }
            .asObservable()
        }
        
        requestResult.subscribe(onNext: {
            print($0)
        }, onCompleted: {
            print("ONCOMPLETE")
        })
        
        self.errorCheck = requestResult
            .filter { $0 != .success }
            .map { action in
                return model.setAlert(action: action)
            }
            .asSignal(onErrorSignalWith: .empty())
        
        self.nextCheck = requestResult
            .filter { $0 == .success }
            .map { action -> Void in
                print(action)
                return Void()
            }
            .asDriver(onErrorDriveWith: .empty())
        
        idDriver = idInfo.asSignal(onErrorSignalWith: .empty())
        
    }
}
